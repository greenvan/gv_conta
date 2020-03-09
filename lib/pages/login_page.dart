import 'package:flutter/material.dart';
import 'package:gvconta/system/auth_provider.dart';

class NameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Name can\'t be empty' : null;
  }
}

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
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

  String _email, _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;

//TODO: si es modo register, validar si los dos passwords son iguales

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
        // TODO Para asegurarnos de que quita el espacio utilizar lo siguiente
        //_email.toString().trim()
        if (_formType == FormType.login) {
          String userId =
              await auth.signInWithEmailAndPassword(_email, _password);

          print('User logged in: $userId');
        } else {
          String userId =
              await auth.createUserWithEmailAndPassword(_email, _password);

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
        title: Text('Login Page'),
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
    if (_formType == FormType.register)
      return [
        TextFormField(
          decoration: InputDecoration(labelText: 'Name'),
          validator: NameFieldValidator.validate,
          onSaved: (value) => _email = value,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          // inputFormatters: [widget.inputFormatter],
          validator: EmailFieldValidator.validate,
          onSaved: (value) => _email = value,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          validator: PasswordFieldValidator.validate,
          onSaved: (value) => _password = value,
          obscureText: true,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Repeat Password'),
          validator: PasswordFieldValidator.validate,
          onSaved: (value) => _password = value,
          obscureText: true,
        ),
      ];

    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: EmailFieldValidator.validate,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        validator: PasswordFieldValidator.validate,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    bool _login = false;
    if (_formType == FormType.login) _login = true;

    return [
      RaisedButton(
        child: Text((_login) ? 'Login' : 'Create an account',
            style: TextStyle(fontSize: 20)),
        onPressed: validateAndSubmit,
      ),
      FlatButton(
        child: Text(
          (_login) ? 'Create an account' : 'Have an account? Log in',
          style: TextStyle(fontSize: 20),
        ),
        onPressed: (_login) ? moveToRegister : moveToLogin,
      )
    ];
  }
}
