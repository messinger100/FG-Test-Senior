import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/repositories/task_repository.dart';
import 'blocs/task_bloc/task_bloc.dart';
import 'blocs/task_bloc/task_event.dart';
import 'screens/task_screen.dart';
import 'utils/hive_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await setupHive(); // Inicializa Hive y registra los adaptadores

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => TaskBloc(TaskRepository())..add(LoadTasks()),
        child: TaskScreen(),
      ),
    );
  }
}
