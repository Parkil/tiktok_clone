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

  static String m0(value) => "${value}";

  static String m1(count) =>
      "${count} ${Intl.plural(count, zero: 'no Comments', one: '${count} Comment', other: '${count} Comments')}";

  static String m2(value) => "${value}";

  static String m3(appName) => "Login to your ${appName} account";

  static String m4(videoCount) =>
      "Create a profile, follow other accounts make your own ${Intl.plural(videoCount, zero: 'no videos', one: 'video', other: 'videos')}, and more.";

  static String m5(appName) => "Sign up for ${appName}";

  static String m6(gender) =>
      "Log in ${Intl.gender(gender, female: 'madam', male: 'sir', other: 'human')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "commentCount": m0,
        "commentTitle": m1,
        "likeCount": m2,
        "loginTitle": m3,
        "signUpAppleTitle":
            MessageLookupByLibrary.simpleMessage("Continue with Apple"),
        "signUpSubTitle": m4,
        "signUpTitle": m5,
        "singUpEmailTitle":
            MessageLookupByLibrary.simpleMessage("Use email and password"),
        "subLogin": m6
      };
}
