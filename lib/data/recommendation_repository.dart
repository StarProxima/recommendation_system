import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:recommendation_system/data/product_model.dart';

abstract class RecommendationRepository {
  //static String serverUrl = "10.0.2.2";
  static String serverUrl = "178.20.41.205";
  static Future<List<Product>?> getRecommendations() async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/recomend",
      port: 5000,
    );

    log(url.normalizePath().toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;

      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }

  static Future<List<Product>?> getProductsSpecialForUser() async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/similar_users",
      port: 5000,
      queryParameters: {"user": "2217"},
    );

    log(url.normalizePath().toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;

      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }

  static Future<List<Product>?> getSimilarProducts(Product product) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/similar_items",
      port: 5000,
      queryParameters: {"product": "${product.name};${product.price.toInt()};${product.merchant}"},
    );
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }

  static Future<List<Product>?> getConnectedProducts(Product product) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/connected",
      port: 5000,
      queryParameters: {"product": "${product.name};${product.price.toInt().toString()};${product.merchant}"},
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }

  static Future<List<Product>?> getProducts(String query) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/globalSearch",
      port: 5000,
      queryParameters: {"search": query},
    );
    var response = await http.get(url);
    log(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }
}
