// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:client/public/file.dart';
import 'package:client/public/lang.dart';
import 'package:client/routes.dart';
import 'package:client/providers/base_notifier.dart';
import 'package:client/providers/teacher_notifier.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  late String account;
  late String password;
  late TextEditingController accountController, passwordController;
  late TeacherNotifier teacherNotifier;

  requestListener() async {
    if (teacherNotifier.operationStatus.value == OperationStatus.loading) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Lang().loading),
          // action: SnackBarAction(label: 'Action', onPressed: () {}),
        ),
      );
    } else if (teacherNotifier.operationStatus.value == OperationStatus.success) {
      bool writeResult = FileHelper().writeFile(
        FileHelper().tokenFileName,
        teacherNotifier.result.data as String,
      );
      if (writeResult) {
        Navigator.of(context).push(
          RouteHelper().generate('/teacher/index', headline: accountController.text),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Lang().loginTokenGenerationFailed),
            // action: SnackBarAction(label: 'Action', onPressed: () {}),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(teacherNotifier.operationMemo),
          // action: SnackBarAction(label: 'Action', onPressed: () {}),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    accountController = TextEditingController();
    passwordController = TextEditingController();
    teacherNotifier = TeacherNotifier();

    teacherNotifier.addListener(requestListener);
  }

  @override
  void dispose() {
    teacherNotifier.removeListener(requestListener);
    teacherNotifier.dispose();
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
            fontWeight: FontWeight.bold,
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
            fontWeight: FontWeight.bold,
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
            if (_formKey.currentState?.validate() != null && accountController.text.isNotEmpty && passwordController.text.isNotEmpty) {
              teacherNotifier.teacherSignIn(
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
        title: Text(Lang().teachers),
      ),
      body: form,
    );
  }
}
