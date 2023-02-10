import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:widget_testing_skillbox/src/utils/validate_email.dart';

void main() {
  group('Login form tests', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    final fieldFinderEmail = find.byValueKey('authEmailKey');
    final fieldFinderPhone = find.byValueKey('authPhoneKey');
    final fieldFinderSubmit = find.text('Отправить');
    const email = 'text@text.';

    test('emailLoginTest', () async {
      await driver.tap(fieldFinderEmail);
      await driver.waitFor(find.text(''));
      await driver.enterText(email);
    });

    test('phoneLoginTest', () async {
      await driver.tap(fieldFinderPhone);
      await driver.waitFor(find.text(''));
      await driver.enterText('2');
    });

    test('submitLoginTest', () async {
      await driver.tap(fieldFinderSubmit);
      if (validateEmail(email)) {
        await driver.waitFor(find.text('Добро пожаловать'));
      } else {
        await driver.waitFor(find.text('Поле email заполнено не корректно'));
      }
    });
  });

  group('switchFormTest', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('switchFormTest', () async {
      final fieldFinderChangeField = find.byValueKey('switchFormKey');
      final fieldFinderSubmit = find.text('Отправить');
      await driver.tap(fieldFinderChangeField);
      await driver.tap(fieldFinderSubmit);
      await driver.waitFor(find.text('Введите имя'));
      await driver.waitFor(find.text('Введите фамилию'));
      await driver.waitFor(find.text('Заполните поле телефон'));
      await driver.waitFor(find.text('Заполните поле email'));
    });
  });

  group('Register form tests', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    final fieldFinderFirstName = find.byValueKey('firstNameKey');
    final fieldFinderLastName = find.byValueKey('lastNameKey');
    final fieldFinderPhone = find.byValueKey('regPhoneKey');
    final fieldFinderEmail = find.byValueKey('regEmailKey');
    final fieldFinderSubmit = find.text('Отправить');
    const email = 'text@text.';

    test('regEmailTest', () async {
      await driver.tap(fieldFinderEmail);
      await driver.waitFor(find.text(''));
      await driver.enterText(email);
    });

    test('regPhoneTest', () async {
      await driver.tap(fieldFinderPhone);
      await driver.waitFor(find.text(''));
      await driver.enterText('2');
    });

    test('regFirstNameTest', () async {
      await driver.tap(fieldFinderFirstName);
      await driver.waitFor(find.text(''));
      await driver.enterText('1');
    });

    test('regFirstNameTest', () async {
      await driver.tap(fieldFinderLastName);
      await driver.waitFor(find.text(''));
      await driver.enterText('2');
    });

    test('regSubmitTest', () async {
      await driver.tap(fieldFinderSubmit);
      if (validateEmail(email)) {
        await driver.waitFor(find.text('Вы успешно зарегистрировались'));
      } else {
        await driver.waitFor(find.text('Емейл не корректный'));
      }
    });
  });
}
