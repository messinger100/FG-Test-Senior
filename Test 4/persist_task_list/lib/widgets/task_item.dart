import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../data/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) {
          BlocProvider.of<TaskBloc>(context).add(ToggleTaskCompletion(task.id));
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          BlocProvider.of<TaskBloc>(context).add(RemoveTask(task.id));
        },
      ),
    );
  }
}
