class MenuItem{
  String name;
  String description;
  double price;
  int quantity;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    this.quantity = 0,
  });

  Map<String, dynamic> toJson(){
    return{
      "name": this.name,
      "description": this.description,
      "price": this.price,
      "quantity": this.quantity
    };
  }

  factory MenuItem.fromJson(Map<String, dynamic> json){
    return MenuItem(
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        price: json["price"]?.toDouble() ?? 0.0,
        quantity: json["quantity"] ?? 0);
  }
}