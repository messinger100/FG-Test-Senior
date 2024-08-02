import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../../data/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc(this._taskRepository) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final tasks = await _taskRepository.getTasks();
    emit(TaskLoaded(tasks));
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    await _taskRepository.addTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    await _taskRepository.updateTask(event.task);
    add(LoadTasks());
  }

  Future<void> _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) async {
    await _taskRepository.deleteTask(event.id);
    add(LoadTasks());
  }

  Future<void> _onToggleTaskCompletion(
      ToggleTaskCompletion event, Emitter<TaskState> emit) async {
    final tasks = await _taskRepository.getTasks();
    final task = tasks.firstWhere((task) => task.id == event.id);
    await _taskRepository.updateTask(
      task.copyWith(isCompleted: !task.isCompleted),
    );
    add(LoadTasks());
  }
}
