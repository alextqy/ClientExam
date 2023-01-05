import 'package:client/Views/common/show_alert_dialog.dart';
import 'package:client/models/manager_model.dart';
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
  String account = '';
  String password = '';
  final accountController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  get accountInput {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: accountController,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            iconSize: 20,
            onPressed: () => accountController.clear(),
            icon: const Icon(Icons.clear),
          ),
          errorStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          icon: const Icon(Icons.person),
          labelText: Lang().account,
          labelStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        // validator: (String? value) {
        //   if (value == null || value.isEmpty) {
        //     return lang.incorrectInput;
        //   } else {
        //     account = value;
        //   }
        //   return null;
        // },
      ),
    );
  }

  get passwordInput {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            iconSize: 20,
            onPressed: () => passwordController.clear(),
            icon: const Icon(Icons.clear),
          ),
          errorStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          icon: const Icon(Icons.lock),
          labelText: Lang().password,
          labelStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        // validator: (String? value) {
        //   if (value == null || value.isEmpty) {
        //     return lang.incorrectInput;
        //   } else {
        //     password = value;
        //   }
        //   return null;
        // },
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
              var result = ManagerApi().managerSignIn(
                accountController.text,
                passwordController.text,
              );
              result.then((value) {
                if (value.state == true) {
                  var writeResult = FileHelper().writeFile(
                    FileHelper().tokenFileName,
                    value.data,
                  );
                  if (writeResult) {
                    var resultInfo = ManagerApi().managerInfo();
                    resultInfo.then(
                      (info) {
                        if (info.state) {
                          var data = ManagerModel.fromJson(info.data);
                          routeArgs['headline'] = data.name;
                          Navigator.of(context).push(
                            RouteHelper().generate('/manager/index', routeArgs),
                          );
                        } else {
                          showAlertDialog(context, Lang().theRequestFailed);
                        }
                      },
                    );
                  } else {
                    showAlertDialog(context, Lang().loginTokenGenerationFailed);
                  }
                } else {
                  showAlertDialog(context, value.memo);
                }
              }).catchError((e) {
                showAlertDialog(context, Lang().theRequestFailed);
              });
            }
          },
          child: Text(
            Lang().submit,
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
        title: Text(Lang().login),
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
}
