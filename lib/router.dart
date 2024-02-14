import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeUrl,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          name: "username_screen",
          path: "username",
          builder: (context, state) => const UserNameScreen(),
        ),
        GoRoute(
          name: "email_screen",
          path: "email",
          builder: (context, state) {
            final args = state.extra as EmailScreenArgs; // as 를 선언 하면 일종의 casting 역할을 한다
            return EmailScreen(userName: args.username,);
          },
        ),
      ],
    ),
    /*
    GoRoute(
      name: "username_screen",
      path: UserNameScreen.routeName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const UserNameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: EmailScreen.routeName,
      builder: (context, state) {
        final args =
            state.extra as EmailScreenArgs; // as 를 선언 하면 일종의 casting 역할을 한다
        return EmailScreen(
          userName: args.username,
        );
      },
    ),*/
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
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
