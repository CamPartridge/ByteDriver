import 'dart:convert';
import 'dart:math';

import 'package:bytedriver_app/pages/sign_up.dart';
import 'package:bytedriver_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'package:bytedriver_app/models/User.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _SecondState();
}

class _SecondState extends State<login> {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  void _goBack() {
    Navigator.pop(context);
  }

  void _signUP() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const sign_up())
    );
  }


  Future<void> _loginUser() async{

    print("Login user");

    print(emailController.text.toString());
    print(passwordController.text.toString());

    Map loginUser = {
      'Email' : emailController.text.toString(),
      'Password': passwordController.text.toString(),
    };

    String url = "http://10.0.2.2:8080/user/login";

    var loginUserJSON = jsonEncode(loginUser);

    final requestLink = Uri.parse(url);

    http.Response response = await http.post(
      requestLink,
      headers: {"Content-Type": "application/json"},
      body: loginUserJSON,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      User loggedInUser = new User.fromJson(jsonDecode(response.body));
      userEmail = loggedInUser.email;
      userID = loggedInUser.userid;
      savedUser = loggedInUser;

      isLoggedIn = true;

      emailController.clear();
      passwordController.clear();

      _goBack();
    } else if (response.statusCode == 401){
      Toast.show("Incorrect Password :( \nPlease try again.",
          duration: 3,
          textStyle: TextStyle (fontSize:50, color: Colors.red),
          backgroundColor: Colors.white70
      );
    }else if (response.statusCode == 404){
      Toast.show("No user found with that Email :(",
          duration: 3,
          textStyle: TextStyle (fontSize:50, color: Colors.red),
          backgroundColor: Colors.white70
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        backgroundColor: const Color(0xFF000e01),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Column(
          children: [

            SizedBox(height: 50,),
            FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              mini: true,
              backgroundColor: const Color(0xFF8bff00),
              onPressed: _goBack,


              child: const Icon(Icons.arrow_back, color: Colors.black, size: 25),),
          ],
        ),

        body: Column(
              children: <Widget>[

                SizedBox(height: 40,),

              Center(
              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: 200,),
                    Text(
                      "Login",
                      style: TextStyle(color: const Color(0xFF0DF205),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Form(child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email",
                                hintText: "Enter Email",
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {

                              },
                              validator: (value) {
                                return value!.isEmpty ? 'Please enter email' : null;
                              },
                            ),
                          ),
                          SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "Enter Password",
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value) {

                              },
                              validator: (value) {
                                return value!.isEmpty
                                    ? 'Please enter password'
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: MaterialButton(
                              minWidth: double.infinity,
                                onPressed: _loginUser,
                                child: Text('Submit', style: TextStyle(fontSize: 30)),
                                color: const Color(0xFF055902),),
                          )
                        ],
                      ),

                      ),
                    ),
                    Column(
                      children: <Widget> [
                        SizedBox(height: 30,),
                        Text(
                        "No Account?",
                        style: TextStyle(color: const Color(0xFF0DF205),
                          fontSize: 25,),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            onPressed: _signUP,
                            child: Text('Sign Up Now!', style: TextStyle(fontSize: 20, color: const Color(0xFF000000))),
                            color: const Color(0xFF00cc00),),
                        ),
      ]
                    ),
                  ]
              )
        ),]
    )
    );
  }
}
