import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInGoogle() async {
  print('🛜 signInGoogle IN !!!');
  // 認証フローをトリガーする
  final googleUser = await GoogleSignIn().signIn();

  // リクエストから認証情報を取得する
  final googleAuth = await googleUser?.authentication;

  // 新しいクレデンシャルを作成する
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // サインインしたら、UserCredentialを返す。
  return await authRef.signInWithCredential(credential);
}
