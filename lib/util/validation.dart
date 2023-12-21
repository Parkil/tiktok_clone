import '../constants/regexp.dart';

String? isEmailEmpty(String email) {
  if (email.isEmpty) {
    return "Email is Empty";
  }

  return null;
}

String? isEmailValid(String email) {
  if (email.isEmpty) {
    return null;
  }

  if (!emailRegExp.hasMatch(email)) {
    return "Email Not Valid";
  } else {
    return null;
  }
}

String? isPasswordEmpty(String password) {
  if (password.isEmpty) {
    return "Password is Empty";
  }

  return null;
}

String? isPasswordValid(String password) {
  if (password.isEmpty) {
    return null;
  }

  bool lengthChk = password.isNotEmpty && password.length > 8;
  bool charTypeChk = passwordCharTypeExp.hasMatch(password);
  bool specialCharChk = passwordSpecialCharExp.hasMatch(password);

  if (!lengthChk) {
    return "Your password must have 8 to 20 characters";
  } else if (!charTypeChk) {
    return "Your password must include both alphabet and numbers";
  } else if (!specialCharChk) {
    return "Your password must include at least one special character";
  } else {
    return null;
  }
}
