import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pepelist/dashboard.dart';
import 'package:pepelist/main.dart';
import 'package:pepelist/register.dart';
import 'package:pepelist/utils/constants.dart';

class LoginPage extends StatefulWidget {
  final String email;
  final String password;

  LoginPage({this.email, this.password});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double width;
  double height;
  bool submitting = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.email != null) {
      emailController.text = widget.email;
      passwordController.text = widget.password;
    }
    // TODO: Delete
    else {
      emailController.text = 'h@gmail.com';
      passwordController.text = '123456';
    }
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent[100],
                  kOrange0,
                  Colors.grey[400],
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Center(
              child: Container(
                width: width - 500,
                height: height - 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [kItemCardShadow],
                  color: Colors.grey[100],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("loginpic.jpg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 72, vertical: 56),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Image.asset(
                                    'logo.png',
                                    scale: 2,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 80),
                                  child: Text(
                                    'Login',
                                    style: kHeaderTextStyle.copyWith(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: emailController,
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                          hintText: 'Email Address',
                                          hintStyle: kDefaultTextStyle,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Invalid Name';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 4),
                                      TextFormField(
                                        controller: passwordController,
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                          hintText: 'Password',
                                          hintStyle: kDefaultTextStyle,
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Invalid Password';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 120),
                                Container(
                                  height: 48,
                                  width: width / 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: InkWell(
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    mouseCursor: submitting
                                        ? null
                                        : MaterialStateMouseCursor.clickable,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          submitting ? 'Logging in' : 'Login',
                                          style: kHeaderTextStyle.copyWith(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 24),
                                        submitting
                                            ? kSpinKitLoader
                                            : FaIcon(
                                                FontAwesomeIcons
                                                    .solidArrowAltCircleRight,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                      ],
                                    ),
                                    onTap: () {
                                      if (_formKey.currentState.validate() &&
                                          !submitting) {
                                        login();
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 80, 0, 0),
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text("Don't have an account?"),
                                          Container(
                                            height: 20,
                                            width: 70,
                                            child: FlatButton(
                                                hoverColor: Colors.transparent,
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegisterPage()),
                                                  );
                                                },
                                                child: Text(
                                                  "Sign Up",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                )),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 26,
            top: 26,
            child: Row(
              children: [
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  mouseCursor: MaterialStateMouseCursor.clickable,
                  child: FaIcon(
                    FontAwesomeIcons.arrowAltCircleLeft,
                    color: kGrey4,
                    size: 32,
                  ),
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Main Page",
                    style: TextStyle(color: Colors.grey[700], fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void login() {
    // Login through DB
    setState(() {
      submitting = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    http.post('https://techvestigate.com/pepelist/php/login.php', body: {
      "email": email,
      "password": password,
    }).then((res) {
      List<String> echoes = res.body.split(',');
      if (echoes[0] == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(
              name: echoes[1],
              email: echoes[2],
            ),
          ),
        );
      } else {
        print('[-] Login Failed');
      }
      setState(() {
        submitting = false;
      });
    }).catchError((err) {
      print(err);
    });
  }
}
