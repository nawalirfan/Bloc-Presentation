import 'dart:convert';
import 'dart:ffi';
import 'package:bloc_state_management/models/product_model.dart';
import "package:http/http.dart" as http;
import 'package:bloc_state_management/models/user_model.dart';

class UserApiClient {
  final http.Client httpClient;

  UserApiClient({required this.httpClient});

  Future<List<Products>> fetchuser() async {
    final userResponse = await httpClient.get(Uri.parse(Endpoints.userUrl));

    if (userResponse.statusCode != 200) {
      throw Exception('error getting user for location');
    }
    List<dynamic> parsedListJson = jsonDecode(userResponse.body)['products'];
    List<Products> itemsList = List<Products>.from(
        parsedListJson.map<Products>((dynamic i) => Products.fromJson(i)));
    return itemsList;
  }

  Future<List<Products>> fetchUserMoc() async {
    return [
      Products(
          id: 1,
          title: "iPhone 9",
          description: "An apple mobile which is nothing like apple",
          price: 549,
          discountPercentage: 12.96,
          rating: 4.69,
          stock: 94,
          brand: "Apple",
          category: "smartphones",
          thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
          images: [
            "https://i.dummyjson.com/data/products/1/1.jpg",
            "https://i.dummyjson.com/data/products/1/2.jpg",
            "https://i.dummyjson.com/data/products/1/3.jpg",
            "https://i.dummyjson.com/data/products/1/4.jpg",
            "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
          ])
    ];
  }
}

class Endpoints {
  static const baseUrl = 'https://dummyjson.com';
  static const String userUrl = '$baseUrl/products';
}
