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

bool isPasswordValid(String password) {
  Map<String, bool>? chkMap = getPasswordChkMap(password);

  if (chkMap == {}) {
    return false;
  }

  return chkMap["lengthChk"] == true && chkMap["charTypeChk"] == true && chkMap["specialCharChk"] == true;
}

Map<String, bool> getPasswordChkMap(String password) {
  if (password.isEmpty) {
    return {};
  }

  bool lengthChk = password.isNotEmpty && password.length >= 8;
  bool charTypeChk = passwordCharTypeExp.hasMatch(password);
  bool specialCharChk = passwordSpecialCharExp.hasMatch(password);

  Map<String, bool> result = {};
  result["lengthChk"] = lengthChk;
  result["charTypeChk"] = charTypeChk;
  result["specialCharChk"] = specialCharChk;

  return result;
}
