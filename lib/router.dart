import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: UserNameScreen.routeName,
      builder: (context, state) => const UserNameScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
        path: EmailScreen.routeName,
        builder: (context, state) {
          final args = state.extra as EmailScreenArgs; // as 를 선언 하면 일종의 casting 역할을 한다
          return EmailScreen(
            userName: args.username,
          );
        }),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final userName = state.pathParameters['username'];
        final tab = state.uri.queryParameters['show'];

        return UserProfileScreen(
          userName: userName!,
          tab: tab!,
        );
      },
    )
  ],
);
