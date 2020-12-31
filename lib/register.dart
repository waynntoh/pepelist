import 'package:flutter/material.dart';
import 'package:pepelist/widgets/navbar.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.white,
            Colors.blueAccent[100],
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NavBar(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: data.size.height / 1.3,
                    maxWidth: data.size.width / 1.5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white12,
                        ),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Container(
                          child: ClipRRect(
                            child: Image.network(
                              'assets/images/registerpic.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Form(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //Email text field
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  height: 80,
                                  width: 600,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: "Email",
                                      suffixIcon: Icon(
                                        Icons.mail,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                //password text field
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  height: 80,
                                  width: 600,
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                //confirm password text field
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  height: 80,
                                  width: 600,
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      hintText: 'Confirm Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                //telephone text field
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  height: 80,
                                  width: 600,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: "Phone Number",
                                      hintText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),

                                //school textfield
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  height: 80,
                                  width: 600,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: "Education ID",
                                      hintText: 'Education ID eg:261482',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.account_box,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                //button to choose student or lecturer
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //student
                                    Container(
                                      height: 150,
                                      width: 150,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints.expand(),
                                        child: FlatButton(
                                          onPressed: () {},
                                          padding: EdgeInsets.all(0.0),
                                          child: Image.network(
                                              'assets/images/studenticon.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    //lecturer
                                    Container(
                                      height: 150,
                                      width: 150,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints.expand(),
                                        child: FlatButton(
                                          onPressed: () {},
                                          padding: EdgeInsets.all(0.0),
                                          child: Image.network(
                                            'assets/images/lecturer.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text("Already have an account?"),
                                    Container(
                                      height: 20,
                                      width: 60,
                                      child: FlatButton(
                                          hoverColor: Colors.transparent,
                                          onPressed: () {},
                                          child: Text(
                                            "Login",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 430,
                                    ),
                                    Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 40,
                                width: 150,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.blue,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(50)),
                                  color: Colors.blue,
                                  onPressed: () {},
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
