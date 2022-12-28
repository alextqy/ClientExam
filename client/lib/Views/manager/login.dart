import 'package:flutter/material.dart';
import 'package:client/public/lang.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  var lang = Lang();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      icon: const Icon(Icons.person),
                      labelText: lang.account,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return lang.incorrectInput;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    obscureText: true,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      icon: const Icon(Icons.lock),
                      labelText: lang.password,
                      labelStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return lang.incorrectInput;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 30),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() != null) {}
                      },
                      child: Text(lang.submit),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
