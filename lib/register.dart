import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:pepelist/login.dart';
import 'package:pepelist/utils/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double width;
  double height;
  bool submitting = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  File _image;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                                  image: NetworkImage(
                                      "assets/images/registerpic.jpg"),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 32),
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundColor: kGrey1,
                                    backgroundImage: _image != null
                                        ? NetworkImage(_image.path)
                                        : NetworkImage(
                                            'assets/images/programmer.png'),
                                    radius: 80,
                                  ),
                                  onTap: () {
                                    getImage();
                                  },
                                ),
                                SizedBox(height: 32),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          hintText: 'Full Name',
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
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          hintText: 'Email Address',
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Invalid Email';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 4),
                                      TextFormField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
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
                                      TextFormField(
                                        controller: confirmPasswordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: 'Confirm Password',
                                        ),
                                        validator: (value) {
                                          if (value !=
                                                  passwordController.text ||
                                              value.isEmpty) {
                                            return 'Incorrect Password';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 72),
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
                                          submitting ? 'Submitting' : 'Sign Up',
                                          style: TextStyle(
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
                                        register(
                                          nameController.text,
                                          emailController.text,
                                          confirmPasswordController.text,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Already have an account?",
                                        textAlign: TextAlign.center,
                                      ),
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
                                                        LoginPage()),
                                              );
                                            },
                                            child: Text(
                                              "Log In",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            )),
                                      ),
                                    ],
                                  )),
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
                    Navigator.pop(context);
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

  Future getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void register(String name, String email, String password) {
    setState(() {
      submitting = true;
    });

    http.post('https://techvestigate.com/pepelist/php/register.php', body: {
      // "encoded_string": base64Image,
      "name": nameController.text,
      "email": emailController.text,
      "password": confirmPasswordController.text,
    }).then((res) {
      if (res.body == "success") {
        print('[+] Registration successful');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              email: emailController.text,
              password: passwordController.text,
            ),
          ),
        );
      } else {
        print('[-] Registration failed');
      }
      setState(
        () {
          submitting = false;
        },
      );
    }).catchError((err) {
      print(err);
    });
  }

  void uploadImage(String email, File imageFile) async {
    if (imageFile == null) {
      imageFile = File('images/dummy_image.png');
    }

    //   String base64Image = base64Encode(imageFile.readAsBytesSync());
    //   http.post('https://techvestigate.com/pepelist/php/upload_profile.php',
    //       body: {
    //         "encoded_string": base64Image,
    //         "email": emailController.text,
    //       }).then((res) {
    //     if (res.body == "Upload Successful") {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => LoginPage(
    //             email: emailController.text,
    //             password: passwordController.text,
    //           ),
    //         ),
    //       );
    //     } else {
    //       print('[-] Upload Failed');
    //     }
    //     setState(() {
    //       submitting = false;
    //     });
    //   }).catchError((err) {
    //     print(err);
    //   });
  }
}
