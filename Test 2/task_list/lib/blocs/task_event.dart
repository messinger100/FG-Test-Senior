import 'package:equatable/equatable.dart';
import '../models/task.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class RemoveTask extends TaskEvent {
  final String id;

  RemoveTask(this.id);

  @override
  List<Object> get props => [id];
}

class ToggleTaskCompletion extends TaskEvent {
  final String id;

  ToggleTaskCompletion(this.id);

  @override
  List<Object> get props => [id];
}