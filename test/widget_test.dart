import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';

void main() {
  group("Form Button Test", () {
    testWidgets("Enable State", (WidgetTester tester) async {
      await tester.pumpWidget(
        // FormButton widget 만 화면에 구성 하는 것이 불가능 하기 때문에 FormButton 을 Directionality 로 wrapping 한다
        const Directionality(
          textDirection: TextDirection.ltr,
          child: FormButton(disabled: false),
        ),
      );

      expect(find.text("Next"), findsOneWidget);
      expect(tester.firstWidget<AnimatedDefaultTextStyle>(find.byType(AnimatedDefaultTextStyle)).style.color, Colors.white);
      expect((tester.firstWidget<AnimatedContainer>(find.byType(AnimatedContainer)).decoration as BoxDecoration).color, const Color(0xff6750a4));
    });
    
    testWidgets("Disabled State", (WidgetTester tester) async {
      await tester.pumpWidget(
        // FormButton widget 만 화면에 구성 하는 것이 불가능 하기 때문에 FormButton 을 Directionality 로 wrapping 한다
        const MediaQuery(
          data: MediaQueryData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: true),
          ),
        ),
      );

      expect(find.text("Next"), findsOneWidget);
      expect(tester.firstWidget<AnimatedDefaultTextStyle>(find.byType(AnimatedDefaultTextStyle)).style.color, Colors.grey.shade400);
    });

    testWidgets("Disabled State DarkMode", (WidgetTester tester) async {
      await tester.pumpWidget(
        // FormButton widget 만 화면에 구성 하는 것이 불가능 하기 때문에 FormButton 을 Directionality 로 wrapping 한다
        const MediaQuery(
          data: MediaQueryData(platformBrightness: Brightness.dark),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: true),
          ),
        ),
      );

      expect(find.text("Next"), findsOneWidget);
      expect((tester.firstWidget<AnimatedContainer>(find.byType(AnimatedContainer)).decoration as BoxDecoration).color, Colors.grey.shade800);
    });

    testWidgets("Disabled State LightMode", (WidgetTester tester) async {
      await tester.pumpWidget(
        // FormButton widget 만 화면에 구성 하는 것이 불가능 하기 때문에 FormButton 을 Directionality 로 wrapping 한다
        const MediaQuery(
          data: MediaQueryData(platformBrightness: Brightness.light),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: FormButton(disabled: true),
          ),
        ),
      );

      expect(find.text("Next"), findsOneWidget);
      expect((tester.firstWidget<AnimatedContainer>(find.byType(AnimatedContainer)).decoration as BoxDecoration).color, Colors.grey.shade300);
    });
  });
}
