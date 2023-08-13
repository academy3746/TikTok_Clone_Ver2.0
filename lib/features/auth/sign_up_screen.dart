// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/auth/common/auth_button.dart';
import 'package:tiktok/features/auth/username_screen.dart';
import 'package:tiktok/generated/l10n.dart';
import '../../utility.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  // Under score in front of properties means private in dart

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
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
                  Text(
                    //"Sign up for TikTok",
                    S.of(context).signUpTitle,
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      //"Create a profile, follow other accounts, make your own videos, and more.",
                      S.of(context).signUpContents(65535),
                      style: const TextStyle(
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
                      child: AuthButton(
                        /*text: "Use Email & Password",*/
                        text: S.of(context).emailForm,
                        icon: const FaIcon(
                          FontAwesomeIcons.user,
                        ),
                      ),
                    ),
                    Gaps.v16,
                    AuthButton(
                      /*text: "Continue with Apple",*/
                      text: S.of(context).continueWithApple,
                      icon: const FaIcon(
                        FontAwesomeIcons.apple,
                      ),
                    ),
                  ],
                  if(orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onEmailTap(context),
                            child: AuthButton(
                              /*text: "Use Email & Password",*/
                              text: S.of(context).emailForm,
                              icon: const FaIcon(
                                FontAwesomeIcons.user,
                              ),
                            ),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            /*text: "Continue with Apple",*/
                            text: S.of(context).continueWithApple,
                            icon: const FaIcon(
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
                  Text(
                    //"Already have an account?",
                    S.of(context).havaAccount,
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.h6,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      //"Log in!",
                      S.of(context).login("male"),
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
