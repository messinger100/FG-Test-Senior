import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../models/task.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    //Registra los manejadores de eventos con sus funciones correspondientes.
    on<LoadTasks>(onLoadTasks);
    on<AddTask>(onAddTask);
    on<RemoveTask>(onRemoveTask);
    on<ToggleTaskCompletion>(onToggleTaskCompletion);
  }

  Future<void> onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    //Aquí se pueden cargar tareas iniciales cuando arranca la app.
    final tasks = <Task>[];
    emit(TaskLoadSuccess(tasks));
  }

  //Agregar Tareas
  void onAddTask(AddTask event, Emitter<TaskState> emit) {
    if (state is TaskLoadSuccess) {
      final currentTasks = (state as TaskLoadSuccess).tasks;
      final updatedTasks = List<Task>.from(currentTasks)
        ..add(event.task);
      emit(TaskLoadSuccess(updatedTasks));//Emite el nuevo estado con la lista actualizada.
    }
  }

  //Remover Tareas
  void onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    if (state is TaskLoadSuccess) {
      final currentTasks = (state as TaskLoadSuccess).tasks;
      final updatedTasks = currentTasks
          .where((task) => task.id != event.id)
          .toList();
      emit(TaskLoadSuccess(updatedTasks));//Emite el nuevo estado con la lista actualizada.
    }
  }

  //Cambiar estado de las Tareas
  void onToggleTaskCompletion(ToggleTaskCompletion event, Emitter<TaskState> emit) {
    if (state is TaskLoadSuccess) {
      final currentTasks = (state as TaskLoadSuccess).tasks;
      final updatedTasks = currentTasks.map((task) {
        return task.id == event.id
            ? task.copyWith(isCompleted: !task.isCompleted) //Cambia el estado de la tarea a completada.
            : task; //Si no coincide, la tarea sigue en la lista.
      }).toList();
      emit(TaskLoadSuccess(updatedTasks));
    }
  }
}