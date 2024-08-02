import 'package:equatable/equatable.dart';
import '../../data/models/task.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}
