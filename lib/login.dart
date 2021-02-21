import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

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
                          controller: email,
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          obscureText: false,
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
                          controller: password,
                          validator: (val) =>
                              val.isEmpty ? 'Enter a password' : null,
                          obscureText: isObscure,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<Auth>(builder: (_, auth, __) {
                              return Flexible(
                                  child: Text(auth.response ?? '',
                                      style: TextStyle(color: Colors.red)));
                            }),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<Auth>()
                                    .resetPassword(context, email.text);
                              },
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.deepPurple),
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
                              primary: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                context.read<Auth>().response = null;
                                await context
                                    .read<Auth>()
                                    .signIn(email.text, password.text);
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
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: Colors.deepPurple, width: 1),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signUp');
                            },
                            child: Text(
                              'Create new account',
                              style: TextStyle(
                                  color: Colors.deepPurple,
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
                                  await context
                                      .read<Auth>()
                                      .signInWithFacebook();
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
                                  await context.read<Auth>().signInWithGoogle();
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
            ],
          ),
        ),
      ),
    );
  }
}
