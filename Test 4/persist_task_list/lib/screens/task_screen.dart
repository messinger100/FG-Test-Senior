import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../blocs/task_bloc/task_state.dart';
import '../widgets/task_list.dart';
import '../data/models/task.dart';

class TaskScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  void _addTask(BuildContext context) {
    final taskName = _taskController.text;
    if (taskName.isNotEmpty) {
      final task = Task(id: DateTime.now().toString(), name: taskName);
      BlocProvider.of<TaskBloc>(context).add(AddTask(task));
      _taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(hintText: 'Enter task'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTask(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TaskLoaded) {
                  return TaskList(tasks: state.tasks);
                } else {
                  return Center(child: Text('Unknown state'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
