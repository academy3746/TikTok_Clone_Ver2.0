/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {onRequest} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = onRequest((request, response) => {
    logger.info("Hello logs!", {structuredData: true});
    response.send("Hello from Firebase!");
});

admin.initializeApp();

export const onVideoCreated = functions.firestore.document("videos/{videoId}").onCreate(async (snapshot, context) => {
    const spawn = require("child-process-promise").spawn;

    const video = snapshot.data();

    await spawn("ffmpeg", [
        "-i",
        video.fileUrl,
        "-ss",
        "00:00:01.000",
        "-vframes",
        "1",
        "-vf",
        "scale=150:-1",
        `/tmp/${snapshot.id}.jpg`,
    ]);

    const storage = admin.storage();

    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
        destination: `thumbnails/${snapshot.id}.jpg`,
    });

    await file.makePublic();

    await snapshot.ref.update({"thumbUrl": file.publicUrl()});

    const db = admin.firestore();

    await db.collection("g5_member").doc(video.creatorUid).collection("videos").doc(snapshot.id).set({
        thumbUrl: file.publicUrl(),
        videoId: snapshot.id
    });
});

export const onLikedCreated = functions.firestore.document("/likes/{likeId}").onCreate(async (snapshot, context) => {
    const db = admin.firestore();

    const [videoId, userId] = snapshot.id.split("000");

    await db.collection("videos").doc(videoId).update({
        likes: admin.firestore.FieldValue.increment(1),
    });

    await db.collection("g5_member").doc(userId).collection("likes").doc(videoId).set({
        datetime: Date.now()
    });

    const video = (await db.collection("videos").doc(videoId).get()).data();

    if (video) {
        const creatorUid = video.creatorUid;

        const user = (await db.collection("g5_member").doc(creatorUid).get()).data();

        if (user) {
            const token = user.token;

            await admin.messaging().sendToDevice(token, {
                data: {
                    "sex": "1234",
                },
                notification: {
                    title: "Someone likes your video!",
                    body: "LIKES +1 ! Congratulation!",
                },
            });
        }
    }
});

export const onLikedRemoved = functions.firestore.document("/likes/{likeId}").onDelete(async (snapshot, context) => {
    const db = admin.firestore();

    const [videoId, userId] = snapshot.id.split("000");

    await db.collection("videos").doc(videoId).update({
        likes: admin.firestore.FieldValue.increment(-1),
    });

    await db.collection("g5_member").doc(userId).collection("likes").doc(videoId).delete();
});

export const onChatRoomRemoved = functions.firestore.document("chat_rooms/{chatRoomId}").onDelete(async (snapshot, context) => {
    const db = admin.firestore();

    const [personA, personB] = snapshot.id.split("000");

    const chatRoomId = snapshot.id;

    await db.collection("g5_member").doc(personA).collection("myChatRooms").doc(chatRoomId).delete();

    await db.collection("g5_member").doc(personB).collection("myChatRooms").doc(chatRoomId).delete();
})
