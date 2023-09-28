// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/auth/common/auth_button.dart';
import 'package:tiktok/features/auth/login_screen.dart';
import 'package:tiktok/features/auth/username_screen.dart';
//import 'package:tiktok/generated/l10n.dart';
import '../../utility.dart';

class SignUpScreen extends StatelessWidget {
  static String routeURL = "signUp";
  static String routeName = "signUp";
  const SignUpScreen({Key? key}) : super(key: key);

  void _onLoginTap(BuildContext context) {
    context.push(LoginScreen.routeName);
    //context.go(LoginScreen.routeName);
    //Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    //context.push("/users/DIO?show=likes");
    //context.push(UsernameScreen.routeName);
    //context.push("/username");
    context.pushNamed(UsernameScreen.routeName);
    //context.go(UsernameScreen.routeName);
    //Navigator.of(context).pushNamed(UsernameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    //print(Localizations.localeOf(context));
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        print(orientation);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    "Sign up for TikTok",
                    //S.of(context).signUpTitle(DateTime.now()),
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Opacity(
                    opacity: 0.7,
                    child: Text(
                      "Create a profile, follow other accounts, make your own videos, and more.",
                      //S.of(context).signUpContents(65535),
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        //color: isDarkMode(context) ? Colors.grey.shade300 : Colors.black45,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onEmailTap(context),
                      child: const AuthButton(
                        text: "Use Email & Password",
                        //text: S.of(context).emailForm,
                        icon: FaIcon(
                          FontAwesomeIcons.user,
                        ),
                      ),
                    ),
                    Gaps.v16,
                    const AuthButton(
                      text: "Continue with Apple",
                      //text: S.of(context).continueWithApple,
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                      ),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: const AuthButton(
                              text: "Use Email & Password",
                              //text: S.of(context).emailForm,
                              icon: FaIcon(
                                FontAwesomeIcons.user,
                              ),
                            ),
                          ),
                        ),
                        Gaps.h16,
                        const Expanded(
                          child: AuthButton(
                            text: "Continue with Apple",
                            //text: S.of(context).continueWithApple,
                            icon: FaIcon(
                              FontAwesomeIcons.apple,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            //color: isDarkMode(context) ? Colors.grey.shade900 : Colors.grey.shade50,
            color: isDarkMode(context) ? null : Colors.grey.shade50,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    //S.of(context).havaAccount,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.h6,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      "Log in!",
                      //S.of(context).login("male"),
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
