import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/task_bloc.dart';
import 'screens/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas (con Bloc y de noche...)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity, //Ajusta la densidad visual para diferentes plataformas.
      ),
      home: BlocProvider(
        create: (context) => TaskBloc(),  //Crea una instancia de TaskBloc para manejar el estado de las tareas.
        child: const TaskScreen(), //La pantalla principal que se muestra al iniciar la aplicación.
      ),
    );
  }
}