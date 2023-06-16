import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/features/user/repo/update_profile_pic.dart';
import 'package:flutter_sns_example/features/user/repo/update_user.dart';
import 'package:flutter_sns_example/routing/router.dart';

final userAsyncNotifierCommand = AsyncNotifierProvider<UserCommand, void>(() {
  return UserCommand();
});

// commandなので必ずvoid型でなければならない。
class UserCommand extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // commandなので必ずvoid型でなければならない。
  }

  Future<void> updateUserEvent({
    required String name,
    required String bio,
  }) async {
    print('🐯 updateUserEvent IN !!!');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await updateUser(
        name: name,
        bio: bio,
      );
    });
    if (!state.isLoading && !state.hasError) {
      ref.watch(routerProvider).pop();
    }
  }

  Future<void> updateProfilePicEvent({
    required File file,
  }) async {
    print('🐯 updateUserEvent IN !!!');

    // state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return updateProfilePic(file);
    });
  }
}
