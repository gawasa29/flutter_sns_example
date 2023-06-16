import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/common/utils/shimmer.dart';
import 'package:flutter_sns_example/features/auth/command/auth_command.dart';
import 'package:flutter_sns_example/features/user/query/user_query.dart';
import 'package:flutter_sns_example/features/user/view/edit_profile_screen.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  static const routePath = '/Profile';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('📱 ProfileScreen !!! ');
    final currentUser = ref.watch(userQueryProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authAsyncNotifierCommand.notifier).signOutEvent();
            },
          ),
        ],
      ),
      body: currentUser.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('Error $err'),
        data: (user) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _ProfilePic(user.profilePic),
                _NameText(user.name),
                _FollowInfo(
                  followerNum: user.followerNum.toString(),
                  followingNum: user.followingNum.toString(),
                ),
                _BioText(user.bio),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfilePic extends ConsumerWidget {
  const _ProfilePic(this.profilePic);

  final String profilePic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          UserImage(
            radius: 64,
            profilePic: profilePic,
          ),
          FloatingActionButton(
            mini: true,
            onPressed: () {
              context.go(EditProfileScreen.routeFullPath);
            },
            child: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    required this.profilePic,
    required this.radius,
    super.key,
  });
  final String profilePic;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: CachedNetworkImage(
        imageUrl: profilePic,
        placeholder: (context, url) => profileImageShimmer(radius),
        errorWidget: (context, url, error) => CircleAvatar(
          radius: radius,
        ),
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundImage: imageProvider,
          radius: radius,
        ),
      ),
    );
  }
}

class _NameText extends ConsumerWidget {
  const _NameText(this.name);

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _FollowInfo extends ConsumerWidget {
  const _FollowInfo({required this.followerNum, required this.followingNum});

  final String followerNum;
  final String followingNum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text(
              'フォロワー',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              followerNum,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        Column(
          children: [
            const Text(
              'フォロー中',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              followingNum,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}

class _BioText extends ConsumerWidget {
  const _BioText(this.bio);

  final String bio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      bio,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}
