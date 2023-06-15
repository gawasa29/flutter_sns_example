import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';

Future<void> signInEmail({
  required String email,
  required String password,
}) async {
  print('🐯 signInEmail IN !!!');
  await authRef.signInWithEmailAndPassword(email: email, password: password);
}
