import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';
import 'package:flutter_sns_example/features/user/domain/user_entity.dart';
import 'package:flutter_sns_example/features/user/repo/refs/user_refs.dart';

Stream<UserEntity> fetchUser() {
  return userDocRef(userId: authRef.currentUser!.uid)
      .snapshots()
      .map((snap) => snap.data()!);
}
