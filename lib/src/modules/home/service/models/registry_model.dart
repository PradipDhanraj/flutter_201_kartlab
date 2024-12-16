// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_201_kartlab/src/modules/products/service/model/product_model.dart';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

class EventModel {
  String id;
  String title;
  DateTime eventDate;
  String desc;
  List<Products> gifts;
  Products? yourGift;

  EventModel({
    required this.id,
    required this.title,
    required this.eventDate,
    required this.desc,
    this.gifts = const [],
    this.yourGift,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        title: json["title"],
        eventDate: DateTime.parse(json["eventDate"]),
        desc: json["desc"],
        gifts: List<Products>.from(json["gifts"].map((x) => Products.fromJson(x))),
        yourGift: json["yourGift"] != null ? Products.fromJson(json["yourGift"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "eventDate": eventDate.toString(),
        "desc": desc,
        "gifts": List<dynamic>.from(
          gifts.map((x) => x.toJson()),
        ),
        "yourGift": yourGift?.toJson(),
      };

  String eventModelToJsonString() => json.encode(toJson());
}
