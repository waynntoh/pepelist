import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pepelist/dashboard.dart';
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
                  Colors.cyanAccent[100],
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Center(
              child: Container(
                width: width - 500,
                height: height - 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [kItemCardShadow],
                  color: Colors.grey[100],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                bottomLeft: Radius.circular(24),
                              ),
                              image: DecorationImage(
                                  image: AssetImage("loginpic.jpg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 72, vertical: 56),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(21),
                            bottomRight: Radius.circular(21),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'logo.png',
                                  scale: 3,
                                ),
                                SizedBox(width: 48),
                                Text(
                                  'Login',
                                  style: kHeaderTextStyle.copyWith(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
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
                                SizedBox(height: 32),
                                Container(
                                  height: 48,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
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
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              mouseCursor: MaterialStateMouseCursor.clickable,
              child: FaIcon(
                FontAwesomeIcons.arrowAltCircleLeft,
                size: 32,
              ),
              onTap: () {
                Navigator.pop(context);
              },
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
