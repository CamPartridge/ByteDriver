import 'dart:convert';
import 'dart:math';

import 'package:bytedriver_app/pages/byter_order.dart';
import 'package:bytedriver_app/pages/driver_order.dart';
import 'package:bytedriver_app/pages/sign_up.dart';
import 'package:bytedriver_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'package:bytedriver_app/models/User.dart';
import 'package:bytedriver_app/models/Order.dart';
import 'package:bytedriver_app/models/MenuItem.dart';

class driver extends StatefulWidget {
  const driver({super.key});

  @override
  State<driver> createState() => _SecondState();
}

class _SecondState extends State<driver> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void _goBack() {
    Navigator.pop(context);
  }

  Future<void> getOrders() async {
    var res =
        await http.get(Uri.parse('http://10.0.2.2:8086/order/Status/Ordered'));

    if (res.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(res.body);
      Map<int, Order> orderMap = {};

      for (var json in jsonList) {
        int orderId = json["OrderID"];
        String itemPrice = (json["ItemPrice"] ?? 0);
        int quantity = json["Quantity"] ?? 0;

        if (orderMap.containsKey(orderId)) {
          // If the orderId is already in the map, merge the orderedItems
          orderMap[orderId]!.orderedItems.add(json);
          orderMap[orderId]!.totalPrice +=
              double.parse(itemPrice) * quantity; // Accumulate total price
          orderMap[orderId]!.totalQuantity +=
              quantity; // Accumulate total quantity
        } else {
          // If the orderId is not in the map, create a new order
          orderMap[orderId] = Order(
            orderId: orderId,
            totalPrice: double.parse(itemPrice) * quantity,
            totalQuantity: quantity,
            status: json["Status"] ?? '',
            orderedItems: [json],
          );
        }
      }

      setState(() {
        orders = orderMap.values.toList();
      });
    } else {
      print('Failed to load orders');
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
          SizedBox(
            height: 50,
          ),
          FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            mini: true,
            backgroundColor: const Color(0xFF8bff00),
            onPressed: _goBack,
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 25),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: orders.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Text(
                  "Orders",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 55, color: const Color(0xFF8bff00)),
                )
              ],
            );
          }
          Order order = orders[index - 1];
          return ListTile(
              title: Text(
                'Order ID: ${order.orderId}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: const Color(0xFF00ff00)),
              ),
              subtitle: Text(
                'Total Price: \$${order.totalPrice.toStringAsFixed(2)}\nTotal Quantity: ${order.totalQuantity}',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              trailing: ElevatedButton(
                child: Text(
                  'View Order',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          driver_order(orderId: order.orderId),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF40fd14), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18.0), // Rounded corners
                  ),
                ),
              ));
        },
      ),
    );
  }
}
