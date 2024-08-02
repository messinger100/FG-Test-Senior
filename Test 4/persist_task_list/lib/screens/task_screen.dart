import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc/task_bloc.dart';
import '../blocs/task_bloc/task_event.dart';
import '../blocs/task_bloc/task_state.dart';
import '../widgets/task_list.dart';
import '../data/models/task.dart';

class TaskScreen extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  TaskScreen({super.key});

  void addTask(BuildContext context) {
    final taskName = taskController.text;
    if (taskName.isNotEmpty) {
      final task = Task(id: DateTime.now().toString(), name: taskName);
      BlocProvider.of<TaskBloc>(context).add(AddTask(task));
      taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manejador de Tareas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(hintText: 'Enter task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => addTask(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskLoaded) {
                  return TaskList(tasks: state.tasks);
                } else {
                  return const Center(child: Text('Estado desconocido'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}