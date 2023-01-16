import 'package:client/Views/common/toast.dart';
import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/login_notifier.dart';
import 'package:client/public/file.dart';
import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';
import 'package:client/routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  late String account;
  late String password;
  late TextEditingController accountController, passwordController;
  late LoginNotifier loginNotifier;

  requestListener() async {
    if (loginNotifier.state.value == OperationStatus.loading) {
      Toast().show(context, message: Lang().loading);
    } else if (loginNotifier.state.value == OperationStatus.success) {
      var writeResult = FileHelper().writeFile(
        FileHelper().tokenFileName,
        loginNotifier.result.data as String,
      );
      if (writeResult) {
        Navigator.of(context).push(
          RouteHelper()
              .generate('/manager/index', headline: accountController.text),
        );
      } else {
        Toast().show(context, message: Lang().loginTokenGenerationFailed);
      }
    } else {
      Toast().show(context, message: loginNotifier.memo);
    }
  }

  @override
  void initState() {
    super.initState();
    accountController = TextEditingController();
    passwordController = TextEditingController();
    loginNotifier = LoginNotifier();

    loginNotifier.addListener(requestListener);
  }

  @override
  void dispose() {
    loginNotifier.removeListener(requestListener);
    loginNotifier.dispose();
    super.dispose();
  }

  ///表单
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
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return Lang().incorrectInput;
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
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return Lang().incorrectInput;
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
            if (_formKey.currentState?.validate() != null &&
                accountController.text.trim().isNotEmpty &&
                passwordController.text.trim().isNotEmpty) {
              loginNotifier.request(
                accountController.text,
                passwordController.text,
              );
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

  get form {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Lang().login),
      ),
      body: form,
    );
  }
}
