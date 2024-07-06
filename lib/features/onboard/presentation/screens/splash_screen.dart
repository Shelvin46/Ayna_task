import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/core/constants/image_url_constants.dart';
import 'package:ayna_task/core/services/shared_pref_services.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[SplashScreen] is a stateful widget which returns a [Scaffold] widget.
///[SplashScreen] contains a [Center] widget which contains a [TweenAnimationBuilder] widget.
///[TweenAnimationBuilder] widget contains a [Transform] widget which contains a [CachedNetworkImage] widget.
/// In this Widget the image will be scaled from 0.5 to 2.0 in 2 seconds.
/// The image is fetched from the [ImageUrlConstants.splashScreenImageUrl].
/// [_isAnimationDone] is a [ValueNotifier] which is set to false initially.
/// When the animation is done, the value of [_isAnimationDone] is set to true through this the Welcome text will be displayed.
///
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  final ValueNotifier<bool> _isAnimationDone = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isAnimationDone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TweenAnimationBuilder<double>(
              onEnd: () async {
                _isAnimationDone.value = true;
                await Future.delayed(const Duration(seconds: 1), () {
                  // check the user is logged in or not and navigate to the respective screen
                  String token = locator<SharedPreferencesService>().token;
                  if (token.isNotEmpty) {
                    context.go('/dashboard-page');
                  } else {
                    context.go('/login-screen');
                  }
                });
              },
              tween: Tween<double>(begin: 40, end: 200),
              duration: const Duration(seconds: 2),
              builder: (BuildContext context, double scale, Widget? child) {
                return SizedBox(
                  height: scale,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: ImageUrlConstants.aynaImageUrl,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
          10.heightBox,
          ValueListenableBuilder<bool>(
            valueListenable: _isAnimationDone,
            builder: (context, isDone, child) {
              if (isDone) {
                return Text(
                  "Welcome to Ayna",
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
