//import 'dart:convert';

// List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

// String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  String categoryId;
  String categoryTitle;

  Categories({
    required this.categoryId,
    required this.categoryTitle,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categoryId: json["category_id"],
        categoryTitle: json["category_title"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_title": categoryTitle,
      };
}

// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

// List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

// String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  String productName;
  String productPrice;
  String productDescription;
  String productThumnailUrl;
  String productCategoryId;
  List<String> productImages;

  Products({
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.productThumnailUrl,
    required this.productCategoryId,
    required this.productImages,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productName: json["product_name"],
        productPrice: json["product_price"],
        productDescription: json["product_description"],
        productThumnailUrl: json["product_thumnail_url"],
        productCategoryId: json["product_category_id"],
        productImages: List<String>.from(json["product_images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_price": productPrice,
        "product_description": productDescription,
        "product_thumnail_url": productThumnailUrl,
        "product_category_id": productCategoryId,
        "product_images": List<dynamic>.from(productImages.map((x) => x)),
      };
}

class RegistryItem {
  final int id;
  final String evetName;
  final String desc;
  DateTime eventDate;
  RegistryItem(this.id, this.evetName, this.eventDate, this.desc);
}
