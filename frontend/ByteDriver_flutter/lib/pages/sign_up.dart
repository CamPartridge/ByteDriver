import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'package:bytedriver_app/models/User.dart';


class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _SecondState();
}

class _SecondState extends State<sign_up> {


  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _goBack() {
    Navigator.pop(context);
  }



  Future<void> _createUser() async{

    print("Creating user");
    print(firstNameController.text.toString());
    print(lastNameController.text.toString());
    print(emailController.text.toString());
    print(phoneNumberController.text.toString());
    print(passwordController.text.toString());

    User newUser = new User(
      userid: -1,
        firstname: firstNameController.text,
        lastname: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phonenumber: phoneNumberController.text,
        type: "Byter");

    String url = "http://10.0.2.2:8080/user";

    var newUserJSON = jsonEncode(newUser);

    final requestLink = Uri.parse(url);
    
    http.Response response = await http.post(
      requestLink,
      headers: {"Content-Type": "application/json"},
      body: newUserJSON,
    );

    print("Response: " + response.body);


    if (response.statusCode == 201) { // If successfully created
      User createdUser = new User.fromJson(jsonDecode(response.body));

      // Clear the text fields if the response is successful
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      passwordController.clear();

      _goBack();
    } else if(response.statusCode == 401){ //INVALID EMAIL FORMAT
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      passwordController.clear();
      Toast.show("Invalid Email or Password :( \nPlease try again.",
          duration: 3,
          textStyle: TextStyle (fontSize:50, color: Colors.red),
          backgroundColor: Colors.white70
      );
    } else if(response.statusCode == 409){ //INVALID EMAIL FORMAT
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      passwordController.clear();
      Toast.show("Email or Phone Number already exists :( \nPlease try again",
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
                        SizedBox(height: 100,),
                        Text(
                          "Sign Up",
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
                                  controller: firstNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                    hintText: "Enter your First Name",
                                    prefixIcon: Icon(Icons.abc),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (String value) {

                                  },
                                  validator: (value) {
                                    return value!.isEmpty ? 'Please enter First Name' : null;
                                  },
                                ),
                              ),
                              SizedBox(height: 15,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 35),
                                child: TextFormField(
                                  controller: lastNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: "Last Name",
                                    hintText: "Enter your Last Name",
                                    prefixIcon: Icon(Icons.abc),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (String value) {

                                  },
                                  validator: (value) {
                                    return value!.isEmpty ? 'Please enter Last Name' : null;
                                  },
                                ),
                              ),
                              SizedBox(height: 15,),

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
                              SizedBox(height: 15,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 35),
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: "Phone Number",
                                    hintText: "Enter your Phone Number",
                                    prefixIcon: Icon(Icons.phone_android),
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (String value) {

                                  },
                                  validator: (value) {
                                    return value!.isEmpty ? 'Please enter your Phone Number' : null;
                                  },
                                ),
                              ),
                              SizedBox(height: 15,),
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
                                  onPressed: _createUser,
                                  child: Text('Register', style: TextStyle(fontSize: 30)),
                                  color: const Color(0xFF055902),),
                              ),

                            ],
                          ),

                          ),
                        ),
                      ]
                  )
              ),]
        )
    );
  }
}
