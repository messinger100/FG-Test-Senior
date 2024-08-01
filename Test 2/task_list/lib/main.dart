import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/task.dart';
import 'services/task_service.dart';
import 'blocs/task_bloc.dart';
import 'screens/task_list.dart';
import 'blocs/task_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

  final TaskService taskService = TaskService();

  runApp(MyApp(taskService: taskService));

  // Cerrar Hive cuando la aplicación se cierre
  Future<void> closeHive() async {
    await Hive.close();
  }

  //WidgetsBinding.instance.addObserver(_MyAppLifecycleObserver(closeHive));
}

class MyApp extends StatelessWidget {
  final TaskService taskService;

  MyApp({required this.taskService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TaskBloc(taskService)..add(LoadTasks()),
        child: TaskList(),
      ),
    );
  }
}

class MyAppLifecycleObserver extends WidgetsBindingObserver {
  final Future<void> Function() onClose;

  MyAppLifecycleObserver(this.onClose);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      onClose();
    }
  }
}
