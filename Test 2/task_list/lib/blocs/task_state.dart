import '../models/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  TaskLoadSuccess(this.tasks);

  List<Object> get props => [tasks];
}

class TaskLoadFailure extends TaskState {}
