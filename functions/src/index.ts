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

export const onLikeCreated = region('asia-northeast3').firestore.document(`likes/{likeId}`).onCreate(async (snapshot, context) => {
  // ffmpeg 같은 로직이 포함 되지 않고 단순 firestore 만 조작 하는 경우 거의 실 시간 으로 처리 된다
  const [videoId, _] = snapshot.id.split("000");
  const db = admin.firestore();
  await db.collection("videos").doc(videoId).update({
    likes: admin.firestore.FieldValue.increment(1)
  });

  const video = (await db.collection("videos").doc(videoId).get()).data();

  if (video) {
    const creatorUid = video.creatorUid;
    const user = (await db.collection("users").doc(creatorUid).get()).data();

    if (user) {
      const message = {
        token: user.token,
        notification: {
          title: "someone likes your video",
          body: "Like + 1 ! Congrats!"
        },
        data: {
          "aaa": "bbb",
          "ccc": "ddd",
        }
      };
      await admin.messaging().send(message);
    }
  }
});

export const onLikeDeleted = region('asia-northeast3').firestore.document(`likes/{likeId}`).onDelete(async (snapshot, context) => {
  const [videoId, _] = snapshot.id.split("000");
  const db = admin.firestore();
  await db.collection("videos").doc(videoId).update({
    likes: admin.firestore.FieldValue.increment(-1)
  });
});
