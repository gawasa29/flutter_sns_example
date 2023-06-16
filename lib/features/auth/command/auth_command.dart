import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/common/error/auth_error.dart';
import 'package:flutter_sns_example/common/utils/toast.dart';
import 'package:flutter_sns_example/features/auth/repo/delete_auth.dart';
import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';
import 'package:flutter_sns_example/features/auth/repo/reset_password.dart';
import 'package:flutter_sns_example/features/auth/repo/sign_in_email.dart';
import 'package:flutter_sns_example/features/auth/repo/sign_in_google.dart';
import 'package:flutter_sns_example/features/auth/repo/sign_out.dart';
import 'package:flutter_sns_example/features/auth/repo/sign_up_email.dart';
import 'package:flutter_sns_example/features/user/domain/user_entity.dart';
import 'package:flutter_sns_example/features/user/repo/create_user.dart';
import 'package:go_router/go_router.dart';

final authAsyncNotifierCommand = AsyncNotifierProvider<AuthCommand, void>(() {
  return AuthCommand();
});

// commandなので必ずvoid型でなければならない。
class AuthCommand extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // commandなので必ずvoid型でなければならない。
  }

  Future<void> signUpEvent({
    required String name,
    required String email,
    required String password,
  }) async {
    print('🐯 signUpEvent IN !!!');
    try {
      state = const AsyncLoading();
      await signUpEmail(
        email: email,
        password: password,
      );
      final user = UserEntity(
        name: name,
        userId: authRef.currentUser!.uid,
        profilePic:
            'https://firebasestorage.googleapis.com/v0/b/pretty-post.appspot.com/o/placeholder.png?alt=media&token=2a883138-dd2c-4480-8c21-1139173770fb',
        bio: '',
        followerNum: 0,
        followingNum: 0,
      );
      await createUser(user);
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (err) {
      final errorMessage = FirebaseAuthErrorExt.fromCode(err.code).message;
      await toast(errorMessage);
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signInEvent({
    required String email,
    required String password,
  }) async {
    print('🐯 signInEvent IN !!!');
    try {
      state = const AsyncLoading();
      await signInEmail(email: email, password: password);
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (err) {
      final errorMessage = FirebaseAuthErrorExt.fromCode(err.code).message;
      await toast(errorMessage);
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signInGoogleEvent() async {
    print('🐯 signInGoogleEvent IN !!!');
    try {
      state = const AsyncLoading();
      await signInGoogle();
      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (err) {
      final errorMessage = FirebaseAuthErrorExt.fromCode(err.code).message;
      await toast(errorMessage);
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signOutEvent() async {
    print('🐯 signOutEvent IN !!!');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => signOut(),
    );
  }

  Future<void> resetPasswordEvent({
    required String email,
    required BuildContext context,
  }) async {
    print('🐯 resetPasswordEvent IN !!!');
    try {
      state = const AsyncLoading();
      await resetPassword(
        email: email,
      );
      state = const AsyncValue.data(null);

      if (!state.isLoading && !state.hasError) {
        if (context.mounted) {
          context.pop();
          await toast('メールを送信しました');
        }
      }
    } on FirebaseAuthException catch (err) {
      final errorMessage = FirebaseAuthErrorExt.fromCode(err.code).message;
      await toast(errorMessage);
      state = const AsyncValue.data(null);
    }
  }

  Future<void> deleteAuthEvent({
    required BuildContext context,
  }) async {
    print('🐯 deleteAuthEvent IN !!!');
    try {
      state = const AsyncLoading();
      await deleteAuth();
      state = const AsyncValue.data(null);

      if (!state.isLoading && !state.hasError) {
        if (context.mounted) {
          await toast('ユーザーを削除しました');
        }
      }
    } on FirebaseAuthException catch (err) {
      final errorMessage = FirebaseAuthErrorExt.fromCode(err.code).message;
      await toast(errorMessage);
      state = const AsyncValue.data(null);
    }
  }
}
