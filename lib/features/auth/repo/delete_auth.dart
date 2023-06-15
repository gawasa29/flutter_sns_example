import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';

Future<void> deleteAuth() async {
  print('🛜 deleteAuth IN !!!');
  await authRef.currentUser!.delete();
  await authRef.signOut();
}
