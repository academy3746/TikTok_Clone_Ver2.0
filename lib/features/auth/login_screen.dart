import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/auth/login_form_screen.dart';
//import 'package:tiktok/generated/l10n.dart';
import '../../utility.dart';
import 'common/auth_button.dart';

class LoginScreen extends StatelessWidget {
  static String routeURL = "login";
  static String routeName = "login";
  const LoginScreen({Key? key}) : super(key: key);

  void _onSignUpTap(BuildContext context) {
    /// Avoid Infinite Back: Stack 제거
    context.pop();
    //context.go(SignUpScreen.routeName);
    //Navigator.of(context).pop();
  }

  void _onLoginEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginFormScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                "Log in to TikTok",
                //S.of(context).loginTitle,
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v14,
              const Opacity(
                opacity: 0.7,
                child: Text(
                  "Manage your account, check notifications, comment on videos, and more.",
                  //S.of(context).loginContents,
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    /*color: isDarkMode(context) ? Colors.grey.shade300 : Colors.black45,*/
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onLoginEmailTap(context),
                child: const AuthButton(
                  text: "Use Email & Password",
                  //text: S.of(context).loginWithEmail,
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                  ),
                ),
              ),
              Gaps.v16,
              const AuthButton(
                text: "Continue with Apple",
                //text: S.of(context).loginWithApple,
                icon: FaIcon(
                  FontAwesomeIcons.apple,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                "Don't have an account?",
                //S.of(context).noAccount,
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h6,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  "Sign up!",
                  //S.of(context).signUp,
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
  }
}
