import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class BirthDayScreen extends StatefulWidget {
  const BirthDayScreen({super.key});

  @override
  State<BirthDayScreen> createState() => _BirthDayScreenState();
}

class _BirthDayScreenState extends State<BirthDayScreen> {
  final TextEditingController _birthDayController = TextEditingController();
  final DateTime _initialDate = Jiffy.parseFromDateTime(DateTime.now()).subtract(years: 12).dateTime;
  final DateFormat _dateFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(_initialDate);
  }

  // controller 제거 controller 를 제거 하지 않으면 메모리 관련 문제가 발생할 수 있다
  @override
  void dispose() {
    _birthDayController.dispose();
    super.dispose();
  }

  void _setTextFieldDate(DateTime date) {
    String textDate = _dateFormat.format(date);
    _birthDayController.value = TextEditingValue(text: textDate);
  }

  //StatefulWidget 내부 에서는 context 를 받지 않아도 사용이 가능
  void _onNextTab() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const InterestsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Gaps.v40,
          const Text("When is your birthday?",
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w700)),
          Gaps.v8,
          const Text("Your birthday won`t be shown publicly",
              style: TextStyle(fontSize: Sizes.size16, color: Colors.black54)),
          Gaps.v16,
          TextField(
            controller: _birthDayController,
            enabled: false,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
            cursorColor: Theme.of(context).primaryColor,
          ),
          Gaps.v20,
          FormButton(disabled: false, onTap: _onNextTab),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 400,
        surfaceTintColor: Colors.white, // BottomAppBar 의 background 색을 white 로 설정 하려면 surfaceTintColor, color 를 white 로 설정
        color: Colors.white,
        child: SizedBox(
          child: CupertinoDatePicker(
            onDateTimeChanged: _setTextFieldDate,
            maximumDate: _initialDate,
            initialDateTime: _initialDate,
            mode: CupertinoDatePickerMode.date)),
      ),
    );
  }
}
