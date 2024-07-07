import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/core/services/shared_pref_services.dart';
import 'package:ayna_task/features/authentication/presentation/blocs/login/login_bloc.dart';
import 'package:ayna_task/features/authentication/presentation/utils/form_validator.dart';
import 'package:ayna_task/features/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:ayna_task/features/authentication/presentation/widgets/sign_and_sign_up_prompt.dart';
import 'package:ayna_task/features/widgets/ayna_logo_widget.dart';
import 'package:ayna_task/features/widgets/base_widgets.dart';
import 'package:ayna_task/features/widgets/button_loading_widget.dart';
import 'package:ayna_task/features/widgets/button_widget.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart' as go_router;

///[LoginScreen] is the class to display the login screen.
///The login screen contains the email and password fields, ayna logo, login button and sign and sign up prompt.
///

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  // text form fields
  late final textFormFields = [
    CustomTextFormField(
      controller: emailController,
      hintText: "Email",
      validator: locator<FormFieldValidateClass>().isValidEmail,
      keyboardType: TextInputType.emailAddress,
    ),
    CustomTextFormField(
      controller: passwordController,
      hintText: "Password",
      validator: locator<FormFieldValidateClass>().validatePassword,
      isPassword: true,
    ),
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ///[AynaLogoWidget] is the class to display the ayna logo.
          const AynaLogoWidget(),
          30.heightBox,
          Text("Welcome Back", style: Theme.of(context).textTheme.displayLarge),
          30.heightBox,

          ///[ListView.separated] is the class to display the list of widgets with the textFormFields list.
          ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return textFormFields[index];
              },
              separatorBuilder: (context, index) {
                return 25.heightBox;
              },
              itemCount: 2),
          40.heightBox,

          ///[ButtonWidget] is the class to display the button with the text "Log in".
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                // navigate to the dashboard page
                context.go('/dashboard-page');
                // save the token into the shared preferences
                locator<SharedPreferencesService>().saveToken(state.token);
              } else if (state is LoginFailure) {
                // show the error message
                Fluttertoast.showToast(
                  msg: state.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  webBgColor: 'red',
                  fontSize: 16.0,
                  webPosition: "center",
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                // show the loading button
                return const ButtonLoadingWidget();
              }
              // show the login button
              return ButtonWidget(
                buttonText: "Log in",
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    // call the event to login
                    context.read<LoginBloc>().add(
                          LoginButtonPressed(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  }
                },
              );
            },
          ),
          40.heightBox,

          ///[SignInAndSignUpPrompt] is the class to display the sign in and sign up prompt.
          SignInAndSignUpPrompt(
            action: "  Sign Up",
            instruction: "Don't have an account?",
            onTap: () {
              go_router.GoRouter.of(context).go('/sign-up-screen');
            },
          ),
        ],
      ),
    ));
  }
}
