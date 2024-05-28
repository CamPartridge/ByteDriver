import 'dart:convert';

import 'package:bytedriver_app/variables.dart';
import 'package:flutter/material.dart';

import 'package:bytedriver_app/models/Restaurant.dart';
import 'package:bytedriver_app/models/MenuItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class byter_order extends StatefulWidget {
  final Restaurant restaurant;

  const byter_order({super.key, required this.restaurant});

  @override
  _ByterOrderState createState() => _ByterOrderState();
}

class _ByterOrderState extends State<byter_order> {
  List<MenuItem> menuItems = [];

  @override
  void initState() {
    super.initState();
    // Initialize menuItems list with MenuItem objects from restaurant.menu
    menuItems = widget.restaurant.menu.map((jsonItem) => MenuItem.fromJson(jsonItem)).toList();
  }

  void _incrementQuantity(MenuItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void _decrementQuantity(MenuItem item) {
    setState(() {
      if (item.quantity > 0) {
        item.quantity--;
      }
    });
  }

    Future<void> _placeOrder() async{
      int id = 0;
      List<Map<String, dynamic>> requestBody = menuItems
          .where((menuItem) => menuItem.quantity > 0)
          .map((menuItem) {
        return {
          'id': id++, // Assuming MenuItem has an 'id' property
          'name': menuItem.name,
          'price': menuItem.price,
          'quantity': menuItem.quantity,
        };
      }).toList();

      print(requestBody);


      String url = "http://10.0.2.2:9000/cart/";

      var requestBodyJSON = jsonEncode({"menuItems": requestBody});

      final requestLink = Uri.parse(url);

      http.Response response = await http.post(
        requestLink,
        headers: {"Content-Type": "application/json"},
        body: requestBodyJSON,
      );

      if(response.statusCode == 201){
        print(response.body);
        Toast.show("Order Successfully Placed :D",
            duration: 3,
            textStyle: TextStyle (fontSize:50, color: Color(0xFF003300)),
            backgroundColor: Colors.white70
        );

        url = "http://10.0.2.2:8086/order";

        requestBodyJSON = jsonEncode({
          "FirstName": savedUser.firstname,
          "LastName": savedUser.lastname,
          "Email": savedUser.email,
          "UserID": savedUser.userid,
          "menuItems": jsonDecode(response.body)["menuItems"]
        });

        final newRequestLink = Uri.parse(url);

        http.Response newResponse = await http.post(
          newRequestLink,
          headers: {"Content-Type": "application/json"},
          body: requestBodyJSON,
        );

        print(newResponse.statusCode);
        print(newResponse.body);

      } else {
        Toast.show("Something broke :( \nMy bad homeslice",
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
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        backgroundColor: Color(0xFF006d25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.restaurant.name}',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            Text(
              'Location: ${widget.restaurant.location}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height:25),
            Text(
              'Menu',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  MenuItem menuItem = menuItems[index];
                  return ListTile(
                    title: Text(menuItem.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1bf117)
                    ),),
                    subtitle: Text('${menuItem.description}\n\$${menuItem.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                    ),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, size: 25,color: Color(0xFF1bf117)),
                          onPressed: () => _decrementQuantity(menuItem),
                        ),
                        Text(
                          menuItem.quantity.toString(),
                          style: TextStyle(fontSize: 25),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, size: 25,color: Color(0xFF1bf117)),
                          onPressed: () => _incrementQuantity(menuItem),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: _placeOrder,
                child: Text('Place Order', style: TextStyle(fontSize: 40, color: const Color(0xFF000000))),
                color: const Color(0xFF00ff00),),
            ),
          ],
        ),
      ),
    );
  }
}
