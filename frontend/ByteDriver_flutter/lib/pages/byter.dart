import 'dart:convert';
import 'dart:math';

import 'package:bytedriver_app/pages/byter_order.dart';
import 'package:bytedriver_app/pages/sign_up.dart';
import 'package:bytedriver_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'package:bytedriver_app/models/User.dart';
import 'package:bytedriver_app/models/Restaurant.dart';
import 'package:bytedriver_app/models/MenuItem.dart';

class byter extends StatefulWidget {
  const byter({super.key});

  @override
  State<byter> createState() => _SecondState();
}

class _SecondState extends State<byter> {

  String title = 'Byter';
  List<Restaurant> restaurants = [];

  @override
  void initState() {
    super.initState();
    getRestaurants();
  }

  void _goBack() {
    Navigator.pop(context);
  }

  void _goToByter_oder(Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => byter_order(restaurant: restaurant),
      ),
    );
  }

  Future<void> getRestaurants() async {
    var res = await http.get(
        Uri.parse('http://10.0.2.2:5041/restaurantservice/restaurant'));

    if (res.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(res.body);
      List<Restaurant> tempRestaurants = jsonList.map((json) =>
          Restaurant.fromJson(json)).toList();
      print(tempRestaurants[0].menu);
      setState(() {
        restaurants = tempRestaurants;
      });
    } else {
      print('Failed to load restaurants');
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            mini: true,
            backgroundColor: const Color(0xFF8bff00),
            onPressed: _goBack,


            child: const Icon(
                Icons.arrow_back, color: Colors.black, size: 25),),
        ],
      ),
      body: ListView.builder(
        itemCount: restaurants.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Add a SizedBox as the first item to create space at the top
            return Column(
              children: [
                SizedBox(height: 150,),
                Text(
                  "Restaurants",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 55,
                      color: const Color(0xFF8bff00)
                  ),
                )
              ],
            );
          }
          Restaurant restaurant = restaurants[index - 1];
          return ListTile(
            title: Text(restaurant.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 25,
                color: const Color(0xFF00ff00)
            ),),
            subtitle: Text(restaurant.location,
            style: TextStyle(
              fontSize: 17.5,
            ),),
            trailing: ElevatedButton(
              child: Text(
                'Order',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                // Define the action to be taken when the button is pressed
                _goToByter_oder(restaurant);
                print("Order button pressed for ${restaurant.name}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF40fd14), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0), // Rounded corners
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
