import 'dart:convert';
import 'dart:math';

import 'package:bytedriver_app/pages/sign_up.dart';
import 'package:bytedriver_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'package:bytedriver_app/models/User.dart';

class driver extends StatefulWidget {
  const driver({super.key});

  @override
  State<driver> createState() => _SecondState();
}

class _SecondState extends State<driver> {

  void _goBack() {
    Navigator.pop(context);
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
        body: Column()
    );
  }
}
