// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/features/auth/common/form_button.dart';

import '../../constants/sizes.dart';
import '../onboarding/interest_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  bool _obscureText = true;

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // validate method returns true or false.
        _formKey.currentState!.save();
        //print(formData);
        Navigator.of(context).pushAndRemoveUntil(
          // 중첩된 이전 화면들을 스택에서 삭제
          MaterialPageRoute(
            builder: (context) => const InterestScreen(),
          ),
          (route) => false,
          /*(route) {
            print(route);
            return false;
            }*/
        );
      }
    }
    //_formKey.currentState?.validate();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Log in"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  validator: (value) {
                    // Fake Validation
                    //return "Prohibited E-mail address";
                    if (value != null && value.isEmpty) {
                      return "Please, write your E-mail address.";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['email'] = newValue;
                    }
                  },
                  autocorrect: false,
                ),
                Gaps.v16,
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    suffix: GestureDetector(
                      onTap: _toggleObscureText,
                      child: FaIcon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: Colors.grey.shade500,
                        size: Sizes.size20,
                      ),
                    ),
                  ),
                  validator: (value) {
                    // Fake Validation
                    //return "Wrong Password";
                    if (value != null && value.isEmpty) {
                      return "Please, write your password.";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['password'] = newValue;
                    }
                  },
                  autocorrect: false,
                  obscureText: _obscureText,
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(disabled: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
