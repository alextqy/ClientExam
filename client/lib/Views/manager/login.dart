import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/requests/manager_api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  var lang = Lang();
  var managerApi = ManagerApi();
  String? account = '';
  String? password = '';
  final clearAccount = TextEditingController();
  final clearPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get accountInput {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: clearAccount,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            iconSize: 20,
            onPressed: () => clearAccount.clear(),
            icon: const Icon(Icons.clear),
          ),
          errorStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          icon: const Icon(Icons.person),
          labelText: lang.account,
          labelStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        validator: (String? value) {
          account = value;
          if (value == null || value.isEmpty) {
            return lang.incorrectInput;
          }
          return null;
        },
      ),
    );
  }

  get passwordInput {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: clearPassword,
        obscureText: true,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            iconSize: 20,
            onPressed: () => clearPassword.clear(),
            icon: const Icon(Icons.clear),
          ),
          errorStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          icon: const Icon(Icons.lock),
          labelText: lang.password,
          labelStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        validator: (String? value) {
          password = value;
          if (value == null || value.isEmpty) {
            return lang.incorrectInput;
          }
          return null;
        },
      ),
    );
  }

  get submitButton {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 16.0,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(220, 35),
          ),
          onPressed: () {
            if (_formKey.currentState?.validate() != null) {
              var result = managerApi.managerSignIn(account!, password!);
              result.then((value) => print(value.data));
              // showAlertDialog(context);
            }
          },
          child: Text(
            lang.submit,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.login),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        color: Colors.grey,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                accountInput,
                passwordInput,
                submitButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(account! + password!),
            title: Text(lang.title),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(lang.cancel),
              ),
            ],
          );
        });
  }
}
