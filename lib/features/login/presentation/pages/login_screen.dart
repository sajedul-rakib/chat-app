import 'package:chat_app/features/signup/presentation/widget/text_form_field.dart';
import 'package:chat_app/features/splash/presentation/widgets/app_button.dart';
import 'package:chat_app/features/widgets/circular_progress_indicator.dart';
import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/sign_in_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late bool _securePassword;
  late TextEditingController _emailETController;
  late TextEditingController _passwordETController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _securePassword = true;
    _emailETController = TextEditingController();
    _passwordETController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _showPassword() {
    setState(() {
      _securePassword = !_securePassword;
    });
  }

  @override
  void dispose() {
    _emailETController.dispose();
    _passwordETController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              _emailETController.clear();
              _passwordETController.clear();
              Navigator.pushReplacementNamed(
                  context, RouteName.bottomNavBarScreen);

              CustomSnackbar.show(
                  context: context,
                  message: "Log in successful",
                  backgroundColor: Theme.of(context).colorScheme.secondary);
            } else if (state is SignInFailure) {
              CustomSnackbar.show(
                  context: context,
                  message: state.errorMessage,
                  backgroundColor: Theme.of(context).colorScheme.error);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.rocketchat,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Chateo",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.onPrimary)),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputFormField(
                          hintText: 'Enter your email (Required*)',
                          validation: (value) =>
                              value!.isEmpty ? "Enter your email" : null,
                          textEditionController: _emailETController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputFormField(
                          textInputType: TextInputType.visiblePassword,
                          textEditionController: _passwordETController,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your password';
                            } else {
                              return null;
                            }
                          },
                          hintText: 'Enter a unique password (Required*)',
                          obscureText: _securePassword,
                          suffix: InkWell(
                            onTap: () {
                              _showPassword();
                            },
                            child: _securePassword
                                ? const Icon(FontAwesomeIcons.solidEyeSlash)
                                : const Icon(FontAwesomeIcons.solidEye),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        (state is SignInProccess)
                            ? const Center(
                                child: CustomCircularProgressIndicator(),
                              )
                            : AppButton(
                                buttonTitle: "Log In",
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                onPressed: () {
                                  // context.goNamed(RouteName.bottomNavBarScreen);
                                  if (_formKey.currentState?.validate() ??
                                      true) {
                                    context.read<SignInBloc>().add(
                                        SignInRequired(
                                            email:
                                                _emailETController.text.trim(),
                                            password: _passwordETController.text
                                                .trim()));
                                  }
                                },
                              ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RouteName.signInScreen);
                            },
                            child: Text(
                              'Don\'t have an account? Sign in',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
