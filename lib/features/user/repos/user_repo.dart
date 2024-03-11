import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/features/user/models/user_profile_model.dart';
class UserRepo {
  // create profile
  // get profile
  // update profile

  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _firebaseStorage.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _firebaseStorage.collection("users").doc(uid).get();
    return doc.data();
  }
}

final userRepoProvider = Provider((ref) => UserRepo());
