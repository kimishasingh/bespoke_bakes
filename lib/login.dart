import 'package:flutter/material.dart';

import 'LandingPage.dart';
import 'quote-request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/images/Picture5.png'),
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              child: const Text('Hello!', style: TextStyle(fontSize: 20))),
          Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  helperText: 'Enter your email address here'
                ),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                helperText: 'Enter your password here'

              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // forgot password screen
            },
            child: const Text('Forgot Password'),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                if (nameController.text == 'admin' &&
                    passwordController.text == 'password1') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const LandingPage(title: 'bespoke.bakes')),
                  );
                } else {
                  showAlertDialog(context);
                }
              },
            ),
          ),
        ]));
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Login Attempt Failed"),
    content: const Text("Invalid username/password entered. Please try again"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}