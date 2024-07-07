import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/features/authentication/domain/usecases/sign_up_usecases.dart';
import 'package:ayna_task/features/authentication/presentation/blocs/sign_up/sign_up_bloc.dart';
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

///[SignUpPage] is the class to display the sign up page.
///It extends [StatefulWidget] and takes [SignUpPage] as the argument.
///It has a [State] of [SignUpPage] class.
///It has a [TextEditingController] for full name, email, password and confirm password.
///It has a [GlobalKey] for the form.
///It has a [List] of [CustomTextFormField] for full name, email, password and confirm password.
///It has a [initState] method to initialize the [TextEditingController].
///It has a [dispose] method to dispose the [TextEditingController] and [GlobalKey].
///It has a [build] method to build the UI of the sign up page.

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  // text form fields
  late final textFormFields = [
    CustomTextFormField(
      controller: fullNameController,
      hintText: "Name",
      validator: locator<FormFieldValidateClass>().validateName,
      keyboardType: TextInputType.name,
    ),
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
    CustomTextFormField(
      controller: confirmPasswordController,
      hintText: "Confirm password",
      validator: locator<FormFieldValidateClass>().validatePassword,
      isPassword: true,
    ),
  ];

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    formKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ///[AynaLogoWidget] is the class to display the ayna logo.
            const AynaLogoWidget(),
            30.heightBox,
            Text(
              "Create Account",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            30.heightBox,
            // text form fields
            ListView.separated(
              itemBuilder: (context, index) {
                return textFormFields[index];
              },
              itemCount: textFormFields.length,
              separatorBuilder: (context, index) => 25.heightBox,
              shrinkWrap: true,
              primary: false,
            ),
            40.heightBox,

            ///[ButtonWidget] is the class to display the button with the text "Log in".
            BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  // navigate to the email verification send success show page
                  context.go('/sign-up-success-show-page');

                  // call the function to store the user information in the database
                  locator<SignUpUseCases>().executeUserInfoStore(
                    userEntity: state.user,
                  );
                } else if (state is SignUpFailure) {
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
                if (state is SignUpLoading) {
                  // show the loading button
                  return const ButtonLoadingWidget();
                }
                return ButtonWidget(
                  buttonText: "Sign up",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (passwordController.text.trim() !=
                          confirmPasswordController.text.trim()) {
                        Fluttertoast.showToast(
                          msg: "Password and confirm password should be same",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          webBgColor: 'red',
                          fontSize: 16.0,
                          webPosition: "center",
                        );
                        return;
                      } else {
                        // call the event for sign up
                        context.read<SignUpBloc>().add(
                              SignUpButtonPressed(
                                name: fullNameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    }
                  },
                );
              },
            ),
            40.heightBox,

            ///[SignInAndSignUpPrompt] is the class to display the sign in and sign up prompt.
            SignInAndSignUpPrompt(
              action: "  Log in",
              instruction: "Already have an account?",
              onTap: () => go_router.GoRouter.of(context).go('/login-screen'),
            ),
          ],
        ),
      ),
    );
  }
}
