import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/features/auth/view/forgotten_password_screen.dart';
import 'package:flutter_sns_example/features/auth/view/sign_in_screen.dart';
import 'package:flutter_sns_example/features/auth/view/sign_up_screen.dart';
import 'package:flutter_sns_example/features/chat/view/chat_room_list_screen.dart';
import 'package:flutter_sns_example/features/notification/view/notification_screen.dart';
import 'package:flutter_sns_example/features/post/view/home_screen.dart';
import 'package:flutter_sns_example/features/search/view/search_screen.dart';
import 'package:flutter_sns_example/features/user/view/profile_screen.dart';
import 'package:flutter_sns_example/routing/scaffold_with_bottom_nav_bar.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = Provider((ref) => GlobalKey<NavigatorState>());
final shellNavigatorKey = Provider((ref) => GlobalKey<NavigatorState>());

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      navigatorKey: ref.watch(rootNavigatorKey),
      initialLocation: SignUpScreen.routePath,
      routes: [
        GoRoute(
          path: SignUpScreen.routePath,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SignUpScreen()),
        ),
        GoRoute(
          path: SignInScreen.routePath,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SignInScreen()),
          routes: [
            GoRoute(
              path: ForgottenPasswordScreen.routePath,
              builder: (context, state) => const ForgottenPasswordScreen(),
            )
          ],
        ),
        ShellRoute(
          navigatorKey: ref.watch(shellNavigatorKey),
          builder: (context, state, child) => ScaffoldWithBottomNavBar(
            child: child,
          ),
          routes: [
            GoRoute(
              path: HomeScreen.routePath,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(),
              ),
            ),
            GoRoute(
              path: SearchScreen.routePath,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SearchScreen(),
              ),
            ),
            GoRoute(
              path: NotificationScreen.routePath,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: NotificationScreen(),
              ),
            ),
            GoRoute(
              path: SearchScreen.routePath,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SearchScreen(),
              ),
            ),
            GoRoute(
              path: ChatRoomListScreen.routePath,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ChatRoomListScreen(),
              ),
            ),
            GoRoute(
              path: ProfileScreen.routePath,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileScreen(),
              ),
            ),
          ],
        )
      ],
    );
  },
);
