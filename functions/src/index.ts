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
import {firestore} from "firebase-functions";

initializeApp();

export const onVideoCreated = firestore.document("videos/{videoId}").onCreate(async (snapshot, context) => {
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

  const db = admin.firestore();
  await db.collection("users").doc(video.creatorUid).collection("videos").doc(snapshot.id).set({
    thumbnailUrl: file.publicUrl(),
    videoId: snapshot.id
  });
});

