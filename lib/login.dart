import 'package:flutter/material.dart';
import 'package:return_med/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          obscureText: false,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) =>
                              val.isEmpty ? 'Enter a password' : null,
                          obscureText: isObscure,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              suffixIcon: GestureDetector(
                                child: Tooltip(
                                  message: "Show/Hide password",
                                  child: Icon(isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                onTap: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              ),
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password'),
                        ),
                        Text(error, style: TextStyle(color: Colors.red)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Auth().resetPassword(email);
                              },
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.green[300]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await loginInWith(context, "Email",
                                    email: email, password: password);
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signUp');
                            },
                            child: Text(
                              'Create new account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            ' __________________ or login with __________________',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  await loginInWith(context, "Facebook");
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/facebookicon.png'),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await loginInWith(context, "Google");
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/googleicon.jpg'),
                                  foregroundColor: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> loginInWith(BuildContext context, String provider,
      {String email, String password}) async {
    String response;
    Auth auth = Auth();
    switch (provider) {
      case "Email":
        response = await auth.signIn(email, password);
        break;
      case "Google":
        response = await auth.signInWithGoogle();
        break;
      case "Facebook":
        response = await auth.signInWithFacebook();
        break;
    }
    setState(() {
      error = response;
    });
    return false;
  }
}
