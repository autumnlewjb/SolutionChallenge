import 'package:flutter/material.dart';
import 'package:return_med/src/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _backgroundColor = [
    Colors.deepPurple[300],
    Colors.deepPurple,
    Colors.deepPurple[600]
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
          Colors.deepPurple[300],
          Colors.deepPurple,
          Colors.deepPurple[600]
        ];
        _headingColor = Colors.white;
        break;
      case 1:
        _backgroundColor = [
          Colors.deepPurple[500],
          Colors.deepPurple,
          Colors.deepPurple[300]
        ];
        _headingColor = Colors.white;
        _loginYOffSet = _windowHeight * 3 / 10;
        _titleXOffSet = -_windowWidth * 1.5 / 10;
        _titleYOffSet = _windowHeight * 0.7 / 10;
        _iconXOffSet = _windowWidth * 2.25 / 10;
        _iconYOffSet = -_windowHeight * 0.4 / 10;
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _backgroundColor,
          )),
          child: SafeArea(
            child: AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 1),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedContainer(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                      Expanded(
                        flex: 3,
                        child: AnimatedContainer(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(seconds: 1),
                          transform: Matrix4.translationValues(
                              _iconXOffSet, _iconYOffSet, 1),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/icon.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          // padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
                          child: Text(
                            "INTRO HERE",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          // padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                              // margin: EdgeInsets.fromLTRB(5, 30, 5, 30),
                              // padding: EdgeInsets.all(20),
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 5),
                                        blurRadius: 50,
                                        color: Colors.black.withOpacity(0.4))
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  'Get started',
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        WillPopScope(
          onWillPop: () {
            setState(() {
              _pageState = 0;
              FocusScope.of(context).unfocus();
            });
          },
          child: GestureDetector(
            onTap: () {
              setState(() {
                _pageState = 0;
                FocusScope.of(context).unfocus();
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
          ),
        ),
      ]),
    );
  }
}
