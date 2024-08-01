import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoDetailView extends StatelessWidget {
  final Photo photo;

  const PhotoDetailView({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: Center(
        child: Image.network(photo.imageUrl)
      ),
    );
  }
}