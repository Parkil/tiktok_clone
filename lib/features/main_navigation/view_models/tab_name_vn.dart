import 'package:flutter/material.dart';

/*
  ChangeNotifier 는 사용 하고자 하는 widget 에 MultiProvider 로 wrapping 을 해 주어야 하지만
  ValueNotifier 는 별도 설정 없이 바로 사용이 가능
 */
final tabNameVn = ValueNotifier('home');
