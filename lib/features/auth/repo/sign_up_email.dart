import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';

Future<void> signUpEmail({
  required String email,
  required String password,
}) async {
  print('🐯 signUpEmail IN !!!');
  await authRef.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}
