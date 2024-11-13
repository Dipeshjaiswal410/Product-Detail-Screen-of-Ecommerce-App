import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchProductDetails() async {
  final response = await http.get(
    Uri.parse('https://api.melabazaar.com.np/api/v1/items/product_list/realme-c30/?format=json'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Response Data: $data"); 
  } else {
    print("Failed to load product, status code: ${response.statusCode}");
    throw Exception('Failed to load product');
  }
}




String myAPI = "https://api.melabazaar.com.np/api/v1/items/product_list/realme-c30/?format=json";
