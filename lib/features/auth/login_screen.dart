import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/auth/login_form_screen.dart';
import 'package:tiktok/generated/l10n.dart';
import '../../utility.dart';
import 'common/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _onSignUpTap(BuildContext context) {
    // Avoid Infinite Back: Stack 제거
    Navigator.of(context).pop();
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
              Text(
                //"Log in to TikTok",
                S.of(context).loginTitle,
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v14,
              Opacity(
                opacity: 0.7,
                child: Text(
                  //"Manage your account, check notifications, comment on videos, and more.",
                  S.of(context).loginContents,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    /*color: isDarkMode(context) ? Colors.grey.shade300 : Colors.black45,*/
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onLoginEmailTap(context),
                child: AuthButton(
                  /*text: "Use Email & Password",*/
                  text: S.of(context).loginWithEmail,
                  icon: const FaIcon(
                    FontAwesomeIcons.user,
                  ),
                ),
              ),
              Gaps.v16,
              AuthButton(
                /*text: "Continue with Apple",*/
                text: S.of(context).loginWithApple,
                icon: const FaIcon(
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
              Text(
                //"Don't have an account?",
                S.of(context).noAccount,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h6,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  //"Sign up!",
                  S.of(context).signUp,
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
