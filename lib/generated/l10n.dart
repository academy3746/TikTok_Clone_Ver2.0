// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up for TikTok`
  String get signUpTitle {
    return Intl.message(
      'Sign up for TikTok',
      name: 'signUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create a profile, follow other accounts, make your own {videoCount, plural, =0{no videos} =1{video} other{videos}}, and more.`
  String signUpContents(num videoCount) {
    return Intl.message(
      'Create a profile, follow other accounts, make your own ${Intl.plural(videoCount, zero: 'no videos', one: 'video', other: 'videos')}, and more.',
      name: 'signUpContents',
      desc: '',
      args: [videoCount],
    );
  }

  /// `Use Email & Password`
  String get emailForm {
    return Intl.message(
      'Use Email & Password',
      name: 'emailForm',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get continueWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'continueWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get havaAccount {
    return Intl.message(
      'Already have an account?',
      name: 'havaAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log in! {sex, select, male{guys!} female{girls!} other{sir!}}`
  String login(String sex) {
    return Intl.message(
      'Log in! ${Intl.gender(sex, male: 'guys!', female: 'girls!', other: 'sir!')}',
      name: 'login',
      desc: '',
      args: [sex],
    );
  }

  /// `Log in to TikTok`
  String get loginTitle {
    return Intl.message(
      'Log in to TikTok',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage your account, check notifications, comment on videos, and more.`
  String get loginContents {
    return Intl.message(
      'Manage your account, check notifications, comment on videos, and more.',
      name: 'loginContents',
      desc: '',
      args: [],
    );
  }

  /// `Use Email & Password`
  String get loginWithEmail {
    return Intl.message(
      'Use Email & Password',
      name: 'loginWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get loginWithApple {
    return Intl.message(
      'Continue with Apple',
      name: 'loginWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up!`
  String get signUp {
    return Intl.message(
      'Sign up!',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
