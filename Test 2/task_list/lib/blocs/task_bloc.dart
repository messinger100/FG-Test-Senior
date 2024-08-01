import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskService taskService;

  TaskBloc(this.taskService) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) {
      try {
        final tasks = taskService.getTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(const TaskError("Error loading tasks"));
      }
    });

    on<AddTask>((event, emit) {
      final newTask = Task(id: DateTime.now().toString(), name: event.name);
      taskService.addTask(newTask);
      if (state is TaskLoaded) {
        final updatedTasks = List<Task>.from((state as TaskLoaded).tasks)..add(newTask);
        emit(TaskLoaded(updatedTasks));
      }
    });

    on<RemoveTask>((event, emit) {
      taskService.removeTask(event.id);
      if (state is TaskLoaded) {
        final updatedTasks = (state as TaskLoaded).tasks.where((task) => task.id != event.id).toList();
        emit(TaskLoaded(updatedTasks));
      }
    });

    on<ToggleTaskCompletion>((event, emit) {
      if (state is TaskLoaded) {
        final tasks = List<Task>.from((state as TaskLoaded).tasks);// Crear una nueva lista
        final taskIndex = tasks.indexWhere((task) => task.id == event.id);
        if (taskIndex != -1) {
          print("Tareas ANTES");
          for (final task in tasks) {
            print (task.isCompleted);
          }
          final updatedTask = tasks[taskIndex];
          updatedTask.isCompleted = !updatedTask.isCompleted;  // Invertir el estado de isCompleted
          taskService.updateTask(updatedTask);
          print("Tareas DESPUÉS");
          for (final task in tasks) {
            print (task.isCompleted);
          }
          emit(TaskLoaded(tasks));  // Emitir la nueva lista de tareas
        }
      }
    });
  }
}
