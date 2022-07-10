import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:recommendation_system/data/product_model.dart';

abstract class RecommendationRepository {
  static String serverUrl = "10.0.2.2";
  //static String serverUrl = "178.20.41.205";
  static Future<List<Product>?> getRecommendations() async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/recomend",
      port: 5000,
    );

    try {
      log(url.normalizePath().toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;

        return jsonResponse.map((e) => Product.fromJson(e)).toList();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {}
    return null;
  }

  static Future<List<Product>?> getRecommendationsInShop(
    shopName,
    userId,
  ) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/merchant",
      port: 5000,
      queryParameters: {
        "name": shopName,
        "user": userId.toString(),
      },
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

    try {
      log(url.normalizePath().toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;

        return jsonResponse.map((e) => Product.fromJson(e)).toList();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {}

    return null;
  }

  static Future<List<Product>?> getSimilarProducts(Product product) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/similar_items",
      port: 5000,
      queryParameters: {
        "product":
            "${product.name};${product.price.toInt().toString()};${product.merchant}"
      },
    );
    try {
      log(url.normalizePath().toString());
      var response = await http.get(url);
      log(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;

        return jsonResponse.map((e) => Product.fromJson(e)).toList();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {}
    return null;
  }

  static Future<List<Product>?> getConnectedProducts(Product product) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/connected",
      port: 5000,
      queryParameters: {
        "product":
            "${product.name};${product.price.toInt().toString()};${product.merchant}"
      },
    );
    try {
      log(url.normalizePath().toString());
      var response = await http.get(url);
      log(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;

        return jsonResponse.map((e) => Product.fromJson(e)).toList();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {}
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
    try {
      log(url.normalizePath().toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;

        return jsonResponse.map((e) => Product.fromJson(e)).toList();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {}
    return null;
  }

  static Future<List<Product>?> getProductsInShop(
    String query,
    String shopName,
  ) async {
    var url = Uri(
      scheme: "http",
      host: serverUrl,
      path: "/search_merchantProducts",
      port: 5000,
      queryParameters: {
        "name": query,
        "merchantName": shopName,
      },
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
}
