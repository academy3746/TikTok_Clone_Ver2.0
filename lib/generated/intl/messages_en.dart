// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(sex) =>
      "Log in! ${Intl.gender(sex, female: 'girls!', male: 'guys!', other: 'sir!')}";

  static String m1(videoCount) =>
      "Create a profile, follow other accounts, make your own ${Intl.plural(videoCount, zero: 'no videos', one: 'video', other: 'videos')}, and more.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "continueWithApple":
            MessageLookupByLibrary.simpleMessage("Continue with Apple"),
        "emailForm":
            MessageLookupByLibrary.simpleMessage("Use Email & Password"),
        "havaAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "login": m0,
        "loginContents": MessageLookupByLibrary.simpleMessage(
            "Manage your account, check notifications, comment on videos, and more."),
        "loginTitle": MessageLookupByLibrary.simpleMessage("Log in to TikTok"),
        "loginWithApple":
            MessageLookupByLibrary.simpleMessage("Continue with Apple"),
        "loginWithEmail":
            MessageLookupByLibrary.simpleMessage("Use Email & Password"),
        "noAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up!"),
        "signUpContents": m1,
        "signUpTitle":
            MessageLookupByLibrary.simpleMessage("Sign up for TikTok")
      };
}
