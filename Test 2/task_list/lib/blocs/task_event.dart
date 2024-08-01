import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class LoadTasks extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final String name;

  const AddTask(this.name);

  @override
  List<Object?> get props => [name];
}

class RemoveTask extends TaskEvent {
  final String id;

  const RemoveTask(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTaskCompletion extends TaskEvent {
  final String id;

  const ToggleTaskCompletion(this.id);

  @override
  List<Object?> get props => [id];
}
