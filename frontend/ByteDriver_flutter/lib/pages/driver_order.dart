import 'package:bytedriver_app/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class driver_order extends StatefulWidget {
  final int orderId;

  const driver_order({Key? key, required this.orderId}) : super(key: key);

  @override
  _DriverOrderState createState() => _DriverOrderState();
}

class _DriverOrderState extends State<driver_order> {
  List<dynamic> orderItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    var res = await http.get(Uri.parse('http://10.0.2.2:8086/order/${widget.orderId}'));

    if (res.statusCode == 200) {
      setState(() {
        orderItems = jsonDecode(res.body);
        isLoading = false;
      });
    } else {
      print('Failed to load order details');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> acceptOrder() async {
    // Implement your accept order logic here

    String url = 'http://10.0.2.2:8086/order/${widget.orderId}';

    var updateUserJSON = jsonEncode({
      "FirstName": savedUser.firstname,
      "LastName": savedUser.lastname,
      "Email": savedUser.email,
      "UserID": savedUser.userid
    });

    final requestLink = Uri.parse(url);

    http.Response response = await http.patch(
      requestLink,
      headers: {"Content-Type": "application/json"},
      body: updateUserJSON,
    );

    var res = await http.patch(Uri.parse('http://10.0.2.2:8086/order/${widget.orderId}/Accepted'));

    print(res.statusCode);

    print("Order ${widget.orderId} accepted");
    // For example, you can make an API call to update the order status
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Color(0xFF006d25),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                var item = orderItems[index];
                return ListTile(
                  title: Text(
                    item['ItemName'],
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF00ff00)),
                  ),
                  subtitle: Text(
                    'Price: \$${item['ItemPrice']}\nQuantity: ${item['Quantity']}',
                    style: TextStyle(fontSize: 25),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: acceptOrder,
              child: Text('Accept Order'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF00ff00),
                onPrimary: Colors.black,
                textStyle: TextStyle(fontSize: 30),
              ),
            ),
          ),

          SizedBox(height: 40,),
        ],
      ),
    );
  }
}
