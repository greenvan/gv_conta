import 'package:flutter/material.dart';
import 'package:gvconta/model/user.dart';
import 'package:gvconta/system/auth_provider.dart';
import 'package:gvconta/system/db.dart' as db;
import 'package:gvconta/system/i18n.dart';

class NameFieldValidator {
  static String validate(String value, {String label}) {
    if (label == null || label.isEmpty)
      label = 'labels.noEmpty'; //'Name can\'t be empty';

    return value.isEmpty ? label : null;
  }
}

class EmailFieldValidator {
  static String validate(String value) {
    String emailValue = value.trim();

    if (emailValue.isEmpty) return 'Email can\'t be empty';

    Pattern pattern = "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)";
    final regex = RegExp(pattern);
    if (!regex.hasMatch(emailValue)) return 'Enter a valid email';

    return null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) return 'Password can\'t be empty';
    if (value.length < 8) return 'Password should have at least 8 characters';
    return null;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final passKey = GlobalKey<FormFieldState>();

  String _name, _email, _password, _password2;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        var auth = AuthProvider.of(context).auth;

        if (_formType == FormType.login) {
          String userId =
              await auth.signInWithEmailAndPassword(_email, _password);

          print('User logged in: $userId');
        } else {
          String userId =
              await auth.createUserWithEmailAndPassword(_email, _password);

          db.addUser(User(uid: userId, name: _name, email: _email));

          print('User created: $userId');
        }
      } catch (e) {
        print('Error: $e');
        // TODO: Tratar los errores: Poner una snack bar por ejemplo o un Toast
        // Por ejemplo, al crear un usuario:
        //- ERROR_WEAK_PASSWORD
        // O al hacer sign in o crear el usuario
        // - ERROR_INVALID_EMAIL (No tiene el formato adecuado)
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).loginAppBar),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildInputs() + buildSubmitButtons(),
              )),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    var labels = I18n.of(context);
    if (_formType == FormType.register)
      return [
        TextFormField(
          decoration: InputDecoration(labelText: labels.name),
          validator: (value) =>
              NameFieldValidator.validate(value, label: labels.noEmpty),
          onSaved: (value) => _name = value,
        ),
        TextFormField(
          decoration: InputDecoration(
              labelText: labels.email, hintText: 'test@test.com'),
          keyboardType: TextInputType.emailAddress,
          validator: EmailFieldValidator.validate,
          onSaved: (value) => _email = value.trim(),
        ),
        TextFormField(
          key: passKey,
          decoration: InputDecoration(labelText: labels.password),
          validator: PasswordFieldValidator.validate,
          onSaved: (value) => _password = value,
          obscureText: true,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: labels.repeatPassword),
          validator: (value) {
            var password = passKey.currentState.value;
            return (password == value) ? null : labels.passNoMatch;
          },
          onSaved: (value) => _password2 = value,
          obscureText: true,
        ),
      ];

    return [
      TextFormField(
        decoration:
            InputDecoration(labelText: labels.email, hintText: 'test@test.com'),
        validator: EmailFieldValidator.validate,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => _email = value.trim(),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: labels.password),
        validator: PasswordFieldValidator.validate,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    var labels = I18n.of(context);
    bool _login = false;
    if (_formType == FormType.login) _login = true;

    return [
      RaisedButton(
        child: Text((_login) ? labels.login : labels.createAccount,
            style: TextStyle(fontSize: 20)),
        onPressed: validateAndSubmit,
      ),
      FlatButton(
        child: Text(
          (_login) ? labels.createAccount : labels.alreadyAnAccount,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: (_login) ? moveToRegister : moveToLogin,
      )
    ];
  }
}
