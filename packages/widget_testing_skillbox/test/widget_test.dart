// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_testing_skillbox/src/utils/validate_email.dart';
import 'package:widget_testing_skillbox/src/views/login_view.dart';
//
void main() {
  group('Login view tests', () {
    testWidgets("test description", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginView(),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
      ));
      final fieldFinderEmail = find.byKey(const Key('authEmailKey'));
      final fieldFinderPhone = find.byKey(const Key('authPhoneKey'));
      final fieldFinderSubmit = find.text('Отправить');
      String email = '';
      expect(fieldFinderEmail, findsOneWidget);
      expect(fieldFinderSubmit, findsOneWidget);
      expect(fieldFinderPhone, findsOneWidget);

      bool isValid = validateEmail(email);
      await tester.enterText(fieldFinderEmail, email);
      await tester.tap(fieldFinderSubmit);
      await tester.pump();
      expect(find.text('Введите email'), findsOneWidget);

      email = 'text@text.com';
      isValid = validateEmail(email);
      await tester.enterText(fieldFinderEmail, email);
      await tester.tap(fieldFinderSubmit);
      await tester.pump();
      expect(find.text('Поле email заполнено не корректно'),
          isValid ? findsNothing : findsOneWidget);

      String phone = '';
      await tester.enterText(fieldFinderPhone, phone);
      await tester.tap(fieldFinderSubmit);
      await tester.pump();
      expect(find.text('Введите телефон'), findsOneWidget);

      phone = '2';
      email = 'text@text.com';
      await tester.enterText(fieldFinderPhone, phone);
      await tester.enterText(fieldFinderEmail, email);
      await tester.tap(fieldFinderSubmit);
      await tester.pump();
      expect(find.text('Добро пожаловать'), findsOneWidget);


    });
  });
}
