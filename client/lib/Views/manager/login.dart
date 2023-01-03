import 'package:client/models/route_args.dart';
import 'package:client/public/file.dart';
import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/requests/manager_api.dart';
import 'package:client/routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  var lang = Lang();
  var managerApi = ManagerApi();
  var fileHelper = FileHelper();
  var route = RouteHelper();
  String account = '';
  String password = '';
  final clearAccount = TextEditingController();
  final clearPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get accountInput {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: clearAccount,
        style: const TextStyle(
          fontSize: 18,
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
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return lang.incorrectInput;
          } else {
            account = value;
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
          fontSize: 18,
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
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return lang.incorrectInput;
          } else {
            password = value;
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
              var result = managerApi.managerSignIn(account, password);
              result.then((value) {
                if (value.state == true) {
                  var writeResult = fileHelper.writeFile(
                    fileHelper.tokenFileName,
                    value.data,
                  );
                  if (writeResult) {
                    routeArgs['headline'] = account;
                    Navigator.push(
                      context,
                      route.generate('/manager/index', routeArgs),
                    );
                  } else {
                    showAlertDialog(context, lang.loginTokenGenerationFailed);
                  }
                } else {
                  showAlertDialog(context, value.memo);
                }
              }).catchError((e) {
                showAlertDialog(context, lang.theRequestFailed);
              });
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

  void showAlertDialog(BuildContext context, [String memo = '']) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(memo),
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
