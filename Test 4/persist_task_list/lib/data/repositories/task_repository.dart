import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskRepository {
  static const String _taskBoxName = 'tasks';

  Future<List<Task>> getTasks() async {
    final box = await Hive.openBox<Task>(_taskBoxName);
    return box.values.toList();
  }

  Future<void> addTask(Task task) async {
    final box = await Hive.openBox<Task>(_taskBoxName);
    await box.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    final box = await Hive.openBox<Task>(_taskBoxName);
    await box.put(task.id, task);
  }

  Future<void> deleteTask(String id) async {
    final box = await Hive.openBox<Task>(_taskBoxName);
    await box.delete(id);
  }
}
