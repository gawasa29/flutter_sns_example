import 'package:flutter_sns_example/features/user/domain/user_entity.dart';
import 'package:flutter_sns_example/features/user/repo/refs/user_refs.dart';

Future<void> createUser(UserEntity user) async {
  print('🛜 createUser IN !!!');
  await userDocRef(userId: user.userId).set(user);
}
