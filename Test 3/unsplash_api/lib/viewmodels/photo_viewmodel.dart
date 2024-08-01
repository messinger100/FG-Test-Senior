import 'package:flutter/material.dart';
import 'dart:developer';
import '../models/photo.dart';
import '../services/api_service.dart';

class PhotoViewModel extends ChangeNotifier {
  List<Photo> photosList = [];
  List<Photo> get imagesList => photosList;

  final ApiService apiService;

  PhotoViewModel(this.apiService);

  Future<void> fetchPhotos(String query) async {
    try {
      photosList = await apiService.fetchPhotos(query);
      notifyListeners();
    } catch (error) {
      log('Error al obtener las imágenes: $error');
    }
  }
}
