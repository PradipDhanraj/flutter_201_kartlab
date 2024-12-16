import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_201_kartlab/src/modules/products/service/model/product_model.dart';

abstract class ProductService {
  Future<List<Products>> getProductList();
  Future<List<Categories>> getCategories();
}

class ProductServiceImplementation extends ProductService {
  @override
  Future<List<Products>> getProductList() async {
    final String json = await rootBundle.loadString("assets/json/products.json");
    final data = await jsonDecode(json) as List;
    return data.map((e) => Products.fromJson(e)).toList();
  }

  @override
  Future<List<Categories>> getCategories() async {
    final String json = await rootBundle.loadString("assets/json/categories.json");
    final data = await jsonDecode(json) as List;
    return data.map((e) => Categories.fromJson(e)).toList();
  }
}
