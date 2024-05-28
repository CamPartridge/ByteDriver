
import 'package:bytedriver_app/models/MenuItem.dart';


class Restaurant {
  String name;
  String hours;
  String location;
  List<dynamic> menu;

  Restaurant({
    required this.name,
    required this.hours,
    required this.location,
    required this.menu
});

  Map<String, dynamic> toJson(){
    return {
      "name": this.name,
      "hours": this.hours,
      "location": this.location,
      "menu": this.menu
    };
  }

  factory Restaurant.fromJson(Map<String, dynamic> json){
    return Restaurant(name: json["name"] ?? '',
        hours: json["hours"] ?? '',
        location: json["location"] ?? '',
        menu: json["menu"] ?? '');
  }
}