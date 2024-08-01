import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';
import '../utils/constants.dart';

class ApiService {
  Future<List<Photo>> fetchPhotos(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search/photos?query=$query&client_id=$apiKey'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Error al encontrar imágenes.');
    }
  }
}