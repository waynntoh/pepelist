import 'package:flutter/material.dart';

class User {
  String email;
  String name;
  String password;
  Image image;

  User(String _email, String _name, String _password) {
    this.email = _email;
    this.name = _name;
    this.password = _password;
  }

  void setImage(Image _image) {
    this.image = _image;
  }
}
