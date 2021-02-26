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

  double _windowHeight = 0;
  double _loginYOffSet = 0;
  int _pageState = 0;

  final message = "Return you meds.\nSave the environment.";

  @override
  Widget build(BuildContext context) {
    _windowHeight = MediaQuery.of(context).size.height;
    var _animatedWidget;
    switch (_pageState) {
      case 0:
        _loginYOffSet = _windowHeight;
        _backgroundColor = [
          Colors.deepPurple[300],
          Colors.deepPurple,
          Colors.deepPurple[600]
        ];
        _headingColor = Colors.white;
        _animatedWidget = _titleInColumn();
        break;
      case 1:
        _backgroundColor = [
          Colors.deepPurple[500],
          Colors.deepPurple,
          Colors.deepPurple[300]
        ];
        _headingColor = Colors.white;
        _loginYOffSet = _windowHeight * 3 / 10;
        _animatedWidget = _titleInRow();
        break;
      case 2:
        _headingColor = Colors.white;
        _loginYOffSet = 0;
        _animatedWidget = _titleInColumn();
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _backgroundColor,
          )),
          child: SafeArea(
            child: Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: AnimatedSwitcher(
                          switchInCurve: Curves.easeInToLinear,
                          switchOutCurve: Curves.easeInToLinear,
                          duration: Duration(milliseconds: 500),
                          child: _animatedWidget),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
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
                  ],
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
            onVerticalDragUpdate: (details) {
              if (_pageState == 1) {
                if (details.delta.dy < 0) {
                  setState(() {
                    _pageState = 2;
                  });
                } else if (details.delta.dy > 30) {
                  setState(() {
                    _pageState = 0;
                  });
                }
              } else if (details.delta.dy > 0 && _pageState == 2) {
                setState(() {
                  _pageState = 1;
                });
              }
            },
            child: _loginSheet(),
          ),
        ),
      ]),
    );
  }

  Widget _loginSheet() {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(seconds: 1),
      transform: Matrix4.translationValues(0, _loginYOffSet, 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.swap_vert_circle_rounded),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    _pageState == 1
                        ? "Swipe Up for Full View"
                        : "Swipe Down for Better View",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SafeArea(
              child: LoginPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleInColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              'Return Med',
              style: TextStyle(
                  color: _headingColor,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/icon.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleInRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Return Med',
              style: TextStyle(
                  color: _headingColor,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/icon.png'),
            ),
          ),
        ),
      ],
    );
  }
}
