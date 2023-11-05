import 'package:bespoke_bakes/BakerLandingPage.dart';
import 'package:bespoke_bakes/domain/login_data.dart';
import 'package:bespoke_bakes/domain/user_data.dart';
import 'package:bespoke_bakes/lookup_service.dart';
import 'package:flutter/material.dart';

import 'LandingPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LookupService lookupService = LookupService();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedRole = 'Buyer';

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    List<DropdownMenuItem<String>> dropdownItems = [
      DropdownMenuItem(child: Text('Buyer'), value: 'Buyer'),
      DropdownMenuItem(child: Text('Baker'), value: 'Baker'),
    ];

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
                    helperText: 'Enter your email address here'),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  helperText: 'Enter your password here'),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField(
                  value: selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                  items: dropdownItems)),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                // forgot password screen
              },
              child: const Text('Forgot Password'),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                LoginData loginData = LoginData(
                    username: nameController.text,
                    password: passwordController.text,
                    roleName: selectedRole);
                UserData user = await lookupService.login(loginData);
                navigateToNextPage(context, user, selectedRole);
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

navigateToNextPage(
    BuildContext buildContext, UserData user, String selectedRole) {
  print(selectedRole);
  if (buildContext.mounted) {
    if (user.userId != 0 && selectedRole == 'Buyer') {
      Navigator.push(
        buildContext,
        MaterialPageRoute(
            builder: (context) =>
                LandingPage(title: 'bespoke.bakes', loggedInUser: user)),
      );
    } else if (user.userId != 0 && selectedRole == 'Baker') {
      Navigator.push(
        buildContext,
        MaterialPageRoute(
            builder: (context) =>
                const BakerLandingPage(title: 'bespoke.bakes')),
      );
    } else {
      showAlertDialog(buildContext);
    }
  }
}
