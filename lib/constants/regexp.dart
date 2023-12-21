final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final passwordRegExp = RegExp(r"^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[@$!%*#?&^])[A-Za-z0-9@$!%*#?&^]{9,}$");

final passwordCharTypeExp = RegExp(r"^(?=.*[a-zA-Z])(?=.*[0-9]).+$");

final passwordSpecialCharExp = RegExp(r"^(?=.*[!@#$%^&*]).+$");



