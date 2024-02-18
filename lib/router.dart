import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/user/user_profile_screen.dart';
import 'package:tiktok_clone/features/video/video_recording_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeUrl,
      name: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: UserNameScreen.routeUrl,
      name: UserNameScreen.routeName,
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
      path: EmailScreen.routeUrl,
      name: EmailScreen.routeName,
      builder: (context, state) {
        final args =
            state.extra as EmailScreenArgs; // as 를 선언 하면 일종의 casting 역할을 한다
        return EmailScreen(
          userName: args.username,
        );
      },
    ),
    GoRoute(
      path: PasswordScreen.routeUrl,
      name: PasswordScreen.routeName,
      builder: (context, state) => const PasswordScreen(),
    ),
    GoRoute(
      path: BirthDayScreen.routeUrl,
      name: BirthDayScreen.routeName,
      builder: (context, state) => const BirthDayScreen(),
    ),
    GoRoute(
      path: InterestsScreen.routeUrl,
      name: InterestsScreen.routeName,
      builder: (context, state) => const InterestsScreen(),
    ),
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
    ),
    GoRoute(
      path: VideoRecordingScreen.routeUrl,
      name: VideoRecordingScreen.routeName,
      builder: (context, state) => const VideoRecordingScreen(),
    ),
  ],
);
