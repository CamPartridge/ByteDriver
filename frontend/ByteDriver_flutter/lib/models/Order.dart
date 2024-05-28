class Order {
  int orderId;
  double totalPrice;
  int totalQuantity;
  // String firstname;
  // String lastname;
  String status;
  List<dynamic> orderedItems;

  Order({
    required this.orderId,
    required this.totalPrice,
    required this.totalQuantity,
    // required this.firstname,
    // required this.lastname,
    required this.status,
    required this.orderedItems,
  });

  Map<String, dynamic> toJson() {
    return {
      "OrderID": this.orderId,
      // "FirstName": this.firstname,
      // "LastName": this.lastname,
      "TotalPrice": this.totalPrice,
      "TotalQuantity": this.totalQuantity,
      "Status": this.status,
      "OrderedItems": this.orderedItems
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        orderId: json["OrderID"] ?? '',
        // firstname: json["FirstName"] ?? '',
        // lastname: json["LastName"] ?? '',
        totalPrice: json["ItemPrice"] ?? 0.0,
        // Convert price to double
        totalQuantity: json["Quantity"] ?? 0,
        status: json["Status"] ?? '',
        orderedItems: json["OrderedItems"] ?? [],);
  }
}
