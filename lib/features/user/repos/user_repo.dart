import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
import 'package:mime/mime.dart';


class UserRepo {
  // create profile
  // get profile
  // update profile

  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _firebaseStore
        .collection("users")
        .doc(profile.uid)
        .set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _firebaseStore.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileContentType = lookupMimeType(file.path);

    final fileRef = _firebaseStorage.ref().child("avatars/$fileName");
    await fileRef.putFile(
      file,
      SettableMetadata(
        contentType: fileContentType,
      ),
    );
  }

  Future<void> updateUser(String uid, Map<String, dynamic> map) async {
    await _firebaseStore.collection("users").doc(uid).update(map);
  }
}

final userRepoProvider = Provider((ref) => UserRepo());
