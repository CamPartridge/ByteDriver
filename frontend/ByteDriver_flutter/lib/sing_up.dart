import 'package:flutter/material.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _SecondState();
}

class _SecondState extends State<sign_in> {


  void _goBack() {
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
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
                                  onPressed: () {},
                                  child: Text('Submit', style: TextStyle(fontSize: 30)),
                                  color: const Color(0xFF055902),),
                              )
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
