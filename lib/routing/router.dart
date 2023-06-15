import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_example/features/auth/repo/refs/auth_refs.dart';
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
    final authState = ref.watch(authUserProvider);
    return GoRouter(
      navigatorKey: ref.watch(rootNavigatorKey),
      initialLocation: SignUpScreen.routePath,
      redirect: (context, state) {
        print('🛜 GoRouter redirect IN !!! ');
        // もし認証状態がロード中またはエラーが発生していれば、リダイレクトは行わない。
        if (authState.isLoading || authState.hasError) return null;
        // この時点で hasData==trueであること、すなわち、認証状態が読み取り可能な値であることを保証する。

        // state.locationで現在のパスが取得できる。
        // ここではユーザーがログインしているかどうかを確認しています。
        final isLoggedIn = authState.valueOrNull != null;
        // ユーザーがログインしていたら true、していなかったら false
        if (isLoggedIn) {
          //現在の位置（state.location）がSignUpまたはSignInページであればHomeに移動
          // コード中の state.location.startsWith('/SignUp') と state.location.startsWith('/SignIn') は、
          // 現在のURLが '/SignUp' や '/SignIn' で始まるかどうかを確認しています。これにより、URLが '/SignUp' または
          // '/SignIn' だけでなく、例えば '/SignUp/123' や '/SignIn/123' のようなサブルートも含まれる場合に対応しています。
          if (state.location.startsWith(SignUpScreen.routePath) ||
              state.location.startsWith(SignInScreen.routePath)) {
            return HomeScreen.routePath;
          }
        } else {
          // ユーザーがログインしていないかつ '/SignUp' か '/SignIn'以外のScreenの場合SignUpScreenに移動。
          // if文にしないとログインしてない時は全てSignUpScreenに行ってしまう。
          if (!state.location.startsWith(SignUpScreen.routePath) &&
              !state.location.startsWith(SignInScreen.routePath)) {
            return SignUpScreen.routePath;
          }
        }
        // nullを返すと、もともと飛ぶ場所に移動する。
        return null;
      },
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
