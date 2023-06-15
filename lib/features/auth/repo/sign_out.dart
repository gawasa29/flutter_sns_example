import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';

Future<void> signOut() async {
  print('🐯 signOut Now !!!');
  await authRef.signOut();
}
