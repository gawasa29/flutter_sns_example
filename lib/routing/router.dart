import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/features/auth/view/forgotten_password_screen.dart';
import 'package:flutter_sns_example/features/auth/view/sign_in_screen.dart';
import 'package:flutter_sns_example/features/auth/view/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = Provider((ref) => GlobalKey<NavigatorState>());

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
      ],
    );
  },
);
