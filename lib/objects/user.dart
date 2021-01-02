import 'package:flutter/material.dart';

class User {
  String email;
  String password;
  Image image;

  User(String _email, String _password) {
    this.email = _email;
    this.password = _password;
  }

  void setImage(Image _image) {
    this.image = _image;
  }
}
