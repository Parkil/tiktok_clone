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

  /// `Sign up for {appName}`
  String signUpTitle(String appName) {
    return Intl.message(
      'Sign up for $appName',
      name: 'signUpTitle',
      desc:
          'The title people see when they open the app for the first time (이부분 이 docs 부분에 표시됨)',
      args: [appName],
    );
  }

  /// `Login to your {appName} account`
  String loginTitle(String appName) {
    return Intl.message(
      'Login to your $appName account',
      name: 'loginTitle',
      desc: 'The title people see when they open the login screen',
      args: [appName],
    );
  }

  /// `Create a profile, follow other accounts make your own {videoCount, plural, =0{no videos} =1{video} other{videos}}, and more.`
  String signUpSubTitle(num videoCount) {
    return Intl.message(
      'Create a profile, follow other accounts make your own ${Intl.plural(videoCount, zero: 'no videos', one: 'video', other: 'videos')}, and more.',
      name: 'signUpSubTitle',
      desc: '',
      args: [videoCount],
    );
  }

  /// `Use email and password`
  String get singUpEmailTitle {
    return Intl.message(
      'Use email and password',
      name: 'singUpEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get signUpAppleTitle {
    return Intl.message(
      'Continue with Apple',
      name: 'signUpAppleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in {gender, select, male{sir} female{madam} other{human}}`
  String subLogin(String gender) {
    return Intl.message(
      'Log in ${Intl.gender(gender, male: 'sir', female: 'madam', other: 'human')}',
      name: 'subLogin',
      desc: '',
      args: [gender],
    );
  }

  /// `{value}`
  String likeCount(int value) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString',
      name: 'likeCount',
      desc: 'Anything you want',
      args: [valueString],
    );
  }

  /// `{value}`
  String commentCount(int value) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString',
      name: 'commentCount',
      desc: 'Anything you want',
      args: [valueString],
    );
  }

  /// `{count, plural, =0{no Comments} =1{{count} Comment} other{{count} Comments}}`
  String commentTitle(int count) {
    return Intl.plural(
      count,
      zero: 'no Comments',
      one: '$count Comment',
      other: '$count Comments',
      name: 'commentTitle',
      desc: 'Anything you want',
      args: [count],
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
