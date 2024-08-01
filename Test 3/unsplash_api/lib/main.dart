import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/photo_viewmodel.dart';
import 'services/api_service.dart';
import 'views/photo_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PhotoViewModel(ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Buscador de Imágenes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PhotoListView(),
      ),
    );
  }
}