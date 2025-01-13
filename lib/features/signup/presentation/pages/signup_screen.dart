import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_app/features/signup/presentation/widget/text_form_field.dart';
import 'package:chat_app/features/splash/presentation/bloc/authentication_bloc.dart';
import 'package:chat_app/features/splash/presentation/widgets/app_button.dart';
import 'package:chat_app/features/widgets/circular_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../router/route_name.dart';
import '../../data/models/model.dart';
import '../bloc/sign_up_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  //profile pic
  XFile? profilePic;
  late String _gender = 'male';
  late bool _securePassword;
  late TextEditingController _nameETController;
  late TextEditingController _emailETController;
  late TextEditingController _passwordETController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _securePassword = true;
    _nameETController = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  _emailETController.clear();
                  _passwordETController.clear();
                  _nameETController.clear();
                  AwesomeSnackbarContent(
                    contentType: ContentType.success,
                    title: 'Well done!',
                    message:
                        'Congratulation.You are successfully create you account',
                  );
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationUserChanged());
                }
                if (state is SignUpFailure) {
                  log(state.errorMessage);
                  // CustomSnackBar.customSnackBar(context, state.errorMessage);
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
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
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _profilePicWidgets(context),
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
                              hintText: 'Enter your name (Required*)',
                              validation: (value) =>
                                  value!.isEmpty ? "Enter your name" : null,
                              textEditionController: _nameETController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                            _genderSelectionWidgets(context),
                            const SizedBox(
                              height: 20,
                            ),
                            (state is SignUpProccess)
                                ? const Center(
                                    child: CustomCircularProgressIndicator(),
                                  )
                                : AppButton(
                                    buttonTitle: "Sign In",
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          true) {
                                        MyUser createUser = MyUser(
                                            email:
                                                _emailETController.text.trim(),
                                            fullname:
                                                _nameETController.text.trim(),
                                            gender: _gender);

                                        // log(_emailETController.text);
                                        context.read<SignUpBloc>().add(
                                            SignUpRequired(
                                                user: createUser,
                                                password:
                                                    _passwordETController.text,
                                                picPath: profilePic!.path));
                                      }
                                    },
                                  ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, RouteName.logInScreen);
                                },
                                child: Text(
                                  'Already have an account? Log in',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
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
        ),
      ),
    );
  }

  Widget _profilePicWidgets(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: profilePic != null
                ? Image.file(
                    File(profilePic!.path),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    _gender == 'male'
                        ? 'assets/images/man.jpg'
                        : _gender == 'female'
                            ? 'assets/images/female.jpg'
                            : 'assets/images/others.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton.icon(
            iconAlignment: IconAlignment.end,
            style: OutlinedButton.styleFrom(
                side: BorderSide(
                    width: 2, color: Theme.of(context).colorScheme.onPrimary)),
            icon: Icon(
              CupertinoIcons.photo_camera,
              size: 24,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              _pickProfileImage();
            },
            label: Text(
              "Upload Profile",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            )),
      ],
    );
  }

  Widget _genderSelectionWidgets(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select gender: ",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
        SizedBox(
          width: 350,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(
                      fillColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      value: "male",
                      groupValue: _gender,
                      onChanged: (value) {
                        if (value != _gender) {
                          setState(() {
                            _gender = value!;
                          });
                        }
                      }),
                  Text(
                    "Male",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              ),
              Row(
                children: [
                  Radio(
                      fillColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      value: "female",
                      groupValue: _gender,
                      onChanged: (value) {
                        if (value != _gender) {
                          setState(() {
                            _gender = value!;
                          });
                        }
                      }),
                  Text(
                    "Female",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              ),
              Row(
                children: [
                  Radio(
                      fillColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      value: "others",
                      groupValue: _gender,
                      onChanged: (value) {
                        if (value != _gender) {
                          setState(() {
                            _gender = value!;
                          });
                        }
                      }),
                  Text(
                    "Others",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _pickProfileImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? picImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (picImage != null) {
      setState(() {
        profilePic = picImage;
      });
    }
  }
}
