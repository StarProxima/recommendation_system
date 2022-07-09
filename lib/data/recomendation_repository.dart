import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recommendation_system/data/product_model.dart';

class RecommendationRepository {
  static Future<List<Product>?> getRecommendations() async {
    var url = Uri(
      scheme: "http",
      host: Platform.isAndroid ? '10.0.2.2' : '127.0.0.1',
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
  }

  static Future<List<Product>?> getSimilarProducts(Product product) async {
    var url = Uri(
      scheme: "http",
      host: Platform.isAndroid ? '10.0.2.2' : '127.0.0.1',
      path: "/similar_items",
      port: 5000,
      queryParameters: {
        "product":
            "${product.name};${product.price.toInt().toString()};${product.merchant}"
      },
    );
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<List<Product>?> getConnectedProducts(Product product) async {
    var url = Uri(
      scheme: "http",
      host: Platform.isAndroid ? '10.0.2.2' : '127.0.0.1',
      path: "/connected",
      port: 5000,
      queryParameters: {
        "product":
            "${product.name};${product.price.toInt().toString()};${product.merchant}"
      },
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
