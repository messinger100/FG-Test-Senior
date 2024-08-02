import 'package:hive/hive.dart';
import '../data/models/task.dart';

Future<void> setupHive() async {
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
}
