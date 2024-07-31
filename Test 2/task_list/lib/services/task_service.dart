import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskService {
  final Box<Task> taskBox = Hive.box<Task>('tasks');

  List<Task> getTasks() {
    return taskBox.values.toList();
  }

  void addTask(Task task) {
    taskBox.put(task.id, task);
  }

  void removeTask(String id) {
    taskBox.delete(id);
  }

  void updateTask(Task task) {
    task.save();
  }
}
