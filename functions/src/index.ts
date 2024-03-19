/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as admin from "firebase-admin";
import {initializeApp} from "firebase-admin/app";
import {region} from "firebase-functions";

initializeApp();


// region 을 지정 하지 않으면 us-central 로 고정 된다
export const onVideoCreated = region('asia-northeast3').firestore.document("videos/{videoId}").onCreate(async (snapshot, context) => {
  const video = snapshot.data();

  const spawn = require('child-process-promise').spawn;
  await spawn('ffmpeg', [
    "-i", video.fileUrl,
    "-ss", "00:00:01.000",
    "-vframes", "1",
    "-vf", "scale=150:-1",
    `/tmp/${snapshot.id}.jpg`,
  ]);

  const storage = admin.storage();
  const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
    destination: `thumbnails/tmp/${snapshot.id}.jpg`
  });

  await file.makePublic();
  await snapshot.ref.update({thumbnailUrl: file.publicUrl()});
  await snapshot.ref.update({id: snapshot.ref.id});

  const db = admin.firestore();
  await db.collection("users").doc(video.creatorUid).collection("videos").doc(snapshot.id).set({
    thumbnailUrl: file.publicUrl(),
    videoId: snapshot.id
  });
});

