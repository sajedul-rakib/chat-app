import 'package:chat_app/features/splash/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/route_name.dart';
import '../../../login/domain/repositories/login_repo.dart';
import '../widgets/app_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthenticationBloc(loginRepo: LoginRepo()),
          child: Column(
            children: [
              const Spacer(),
              Center(
                  child: Image.asset(isDark
                      ? 'assets/images/vect2.png'
                      : 'assets/images/frontpage.png')),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'Connect easily with your family and friends over countries',
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Terms & Privacy Policy',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: AppButton(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RouteName.logInScreen);
                  },
                  buttonTitle: "Start Messaging",
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
