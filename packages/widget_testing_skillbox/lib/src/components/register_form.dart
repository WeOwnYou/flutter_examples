import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/validate_email.dart';


class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSuccess = false;
  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            key: const Key('firstNameKey'),
            decoration: const InputDecoration(labelText: 'First name'),
            validator: (value) {
              if (value == '') return 'Введите имя';
              return null;
            },
          ),
          TextFormField(
            key: const Key('lastNameKey'),
            decoration: const InputDecoration(labelText: 'Last name'),
            validator: (value) {
              if (value == '') return 'Введите фамилию';
              return null;
            },
          ),
          TextFormField(
            key: const Key('regPhoneKey'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(labelText: 'Phone'),
            validator: (value) {
              if (value == '') return 'Заполните поле телефон';
              return null;
            },
          ),
          TextFormField(
            key: const Key('regEmailKey'),
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == '') return 'Заполните поле email';
              if (!validateEmail(value??'')) return 'Емейл не корректный';
              return null;
            },
          ),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Отправить'),
          ),
          if (_isSuccess) const Text('Вы успешно зарегистрировались')
        ],
      ),
    );
  }
}
