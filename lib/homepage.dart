import 'package:flutter/material.dart';
import 'package:return_med/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _backgroundColor = [
    Colors.green[200],
    Colors.green[300],
    Colors.green[500]
  ];
  var _headingColor = Colors.black;
  double _loginYOffSet = 0;

  double _titleXOffSet = 0;
  double _titleYOffSet = 0;

  double _iconXOffSet = 0;
  double _iconYOffSet = 0;

  double _windowWidth = 0;
  double _windowHeight = 0;
  int _pageState = 0;

  @override
  Widget build(BuildContext context) {
    _windowHeight = MediaQuery.of(context).size.height;
    _windowWidth = MediaQuery.of(context).size.width;

    switch (_pageState) {
      case 0:
        _loginYOffSet = _windowHeight;
        _titleXOffSet = 0;
        _titleYOffSet = 0;
        _iconXOffSet = 0;
        _iconYOffSet = 0;
        _backgroundColor = [
          Colors.green[200],
          Colors.green[300],
          Colors.green[500]
        ];
        _headingColor = Colors.black;
        break;
      case 1:
        _backgroundColor = [
          Colors.green[800],
          Colors.green[300],
          Colors.green[100]
        ];
        _headingColor = Colors.white;
        _loginYOffSet = 230;
        _titleXOffSet = -60;
        _titleYOffSet = 70;
        _iconXOffSet = 80;
        _iconYOffSet = -10;
        break;
    }

    return Scaffold(
      body: Stack(children: <Widget>[
        SafeArea(
          child: AnimatedContainer(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _backgroundColor,
            )),
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(seconds: 1),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    AnimatedContainer(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(seconds: 1),
                      transform: Matrix4.translationValues(
                          _titleXOffSet, _titleYOffSet, 1),
                      child: Text(
                        'Return Med',
                        style: TextStyle(
                            color: _headingColor,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedContainer(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(seconds: 1),
                        transform: Matrix4.translationValues(
                            _iconXOffSet, _iconYOffSet, 1),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/icon.png'),
                        )),
                    SizedBox(
                      height: 200,
                    ),
                    Container(
                        child: Text(
                      "INTRO HERE",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 150,
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_pageState == 1) {
                              _pageState = 0;
                            } else {
                              _pageState = 1;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green[600]),
                          child: Center(
                            child: Text(
                              'Get started',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _pageState = 0;
            });
          },
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(seconds: 1),
            transform: Matrix4.translationValues(0, _loginYOffSet, 1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 30),
              child: LoginPage(),
            ),
          ),
        )
      ]),
    );
  }
}
