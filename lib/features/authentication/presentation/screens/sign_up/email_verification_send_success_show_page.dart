import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/features/widgets/base_widgets.dart';
import 'package:flutter/material.dart';

///[EmailVerificationSendSuccessShowPage] is the class to show the email verification send success message.
///The email verification send success message contains the check circle icon.
///The check circle icon is animated.
///The check circle icon is animated using the [TweenAnimationBuilder] widget.
class EmailVerificationSendSuccessShowPage extends StatefulWidget {
  const EmailVerificationSendSuccessShowPage({super.key});

  @override
  State<EmailVerificationSendSuccessShowPage> createState() =>
      _EmailVerificationSendSuccessShowPageState();
}

class _EmailVerificationSendSuccessShowPageState
    extends State<EmailVerificationSendSuccessShowPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            curve: Curves.bounceOut,
            tween: Tween<double>(begin: 50, end: 200),
            duration: const Duration(seconds: 2),
            builder: (BuildContext context, double size, Widget? child) {
              return Icon(
                Icons.check_circle_outline,
                size: size,
              );
            },
          ),
          // instruction text
          Text(
            "Email verification link has been sent to your email.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          15.heightBox,
          Text(
            "Please check your email also the spam folder and verify your email address after come back to login page.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
