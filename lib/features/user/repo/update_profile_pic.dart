import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';
import 'package:flutter_sns_example/features/user/repo/refs/user_refs.dart';

Future<void> updateProfilePic(File file) async {
  print('🛜 updateProfilePic IN !!!');
  final filePath =
      'users/${authRef.currentUser!.uid}}/profilePic/${DateTime.now()}.png';
  // Firebase Cloud Storageにアップロード
  final uploadTask =
      await FirebaseStorage.instance.ref().child(filePath).putFile(file);
  final snap = uploadTask;
  final downloadUrl = await snap.ref.getDownloadURL();

  await userDocRef(userId: authRef.currentUser!.uid).update({
    'profilePic': downloadUrl,
  });
  print('🛜 updateProfilePic OUT !!!');
}
