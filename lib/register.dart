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
                  Colors.cyanAccent[100],
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
                                  image: AssetImage("registerpic.jpg"),
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
                            Text(
                              'Registration',
                              style: kHeaderTextStyle.copyWith(
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
                                        : AssetImage('dummy_image.png'),
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
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                          hintText: 'Full Name',
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
                                        controller: emailController,
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                          hintText: 'Email Address',
                                          hintStyle: kDefaultTextStyle,
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
                                      TextFormField(
                                        controller: confirmPasswordController,
                                        obscureText: true,
                                        decoration:
                                            kTextFieldDecoration.copyWith(
                                          hintText: 'Confirm Password',
                                          hintStyle: kDefaultTextStyle,
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
                                          submitting
                                              ? 'Submitting'
                                              : 'Register',
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
