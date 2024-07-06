import 'package:ayna_task/features/authentication/presentation/screens/login/login_page.dart';
import 'package:ayna_task/features/authentication/presentation/screens/sign_up/email_verification_send_success_show_page.dart';
import 'package:ayna_task/features/authentication/presentation/screens/sign_up/sign_up_page.dart';
import 'package:ayna_task/features/chat/presentation/screens/chat_page.dart';
import 'package:ayna_task/features/dashboard/presentation/screens/dashboard_page.dart';
import 'package:ayna_task/features/onboard/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[Routes] is the class to manage the all routes present in the web app.
/// The all routes present the web app will define here
class Routes {
  static GoRouter get router => GoRouter(
        routes: [
          // splash screen route.
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) =>
                const SplashScreen(),
          ),
          // login screen route.
          GoRoute(
            path: '/login-screen',
            builder: (BuildContext context, GoRouterState state) =>
                const LoginScreen(),
          ),
          // sign up screen
          GoRoute(
            path: '/sign-up-screen',
            builder: (BuildContext context, GoRouterState state) =>
                const SignUpPage(),
          ),
          // email verification send success show page
          GoRoute(
            path: '/sign-up-success-show-page',
            builder: (BuildContext context, GoRouterState state) =>
                const EmailVerificationSendSuccessShowPage(),
          ),
          // dashboard page route.
          GoRoute(
            path: '/dashboard-page',
            builder: (BuildContext context, GoRouterState state) =>
                const DashboardPage(),
          ),
          // chat page route.
          GoRoute(
            path: '/chat-page',
            builder: (context, state) {
              return const ChatPage();
            },
          )
        ],
      );
}
