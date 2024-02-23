import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
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
      path: LoginScreen.routeUrl,
      name: LoginScreen.routeName,
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
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(microseconds: 200),
          child: const VideoRecordingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final Animation<Offset> position = Tween(
              begin: const Offset(0, 1), // x, y
              end: Offset.zero, // x, y
            ).animate(animation);

            return SlideTransition(
              position: position,
              child: child,
            );
          },
        );
      }
    ),
    GoRoute(
      path: TutorialScreen.routeUrl,
      name: TutorialScreen.routeName,
      builder: (context, state) => const TutorialScreen(),
    ),
    GoRoute(
      path: LoginFormScreen.routeUrl,
      name: LoginFormScreen.routeName,
      builder: (context, state) => const LoginFormScreen(),
    ),
    GoRoute(
      path: MainNavigationScreen.routeUrl,
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tabName = state.pathParameters['tab']!;
        return MainNavigationScreen(tabName: tabName);
      }
    ),
    GoRoute(
      path: ActivityScreen.routeUrl,
      name: ActivityScreen.routeName,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
      path: ChatsScreen.routeUrl,
      name: ChatsScreen.routeName,
      builder: (context, state) => const ChatsScreen(),
      routes: [
        GoRoute(
          path: ChatDetailScreen.routeUrl,
          name: ChatDetailScreen.routeName,
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ChatDetailScreen(id: id);
          },
        ),
      ],
    ),
  ],
  initialLocation: "/inbox",
);
