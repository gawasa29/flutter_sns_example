import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';
import 'package:flutter_sns_example/features/user/repo/refs/user_refs.dart';

Future<void> updateUser({
  required String name,
  required String bio,
  required String profilePic,
}) async {
  print('🛜 updateUser IN !!!');
  return userDocRef(userId: authRef.currentUser!.uid).update({
    'name': name,
    'bio': bio,
    'profilePic': profilePic,
  });
}
