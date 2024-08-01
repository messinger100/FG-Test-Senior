import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../blocs/task_state.dart';

class TaskList extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: 'Nueva tarea',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final taskName = taskController.text;
              if (taskName.isNotEmpty) {
                BlocProvider.of<TaskBloc>(context).add(AddTask(taskName));
                taskController.clear();
              }
            },
            child: const Text('Agregar Tarea'),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskLoaded) {
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return ListTile(
                        title: Text(task.name),
                        leading: Checkbox(
                          value: task.isCompleted,
                          checkColor: Colors.white,                                                  
                          onChanged: (_) {
                            BlocProvider.of<TaskBloc>(context).add(ToggleTaskCompletion(task.id));
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<TaskBloc>(context).add(RemoveTask(task.id));
                          },
                        ),
                      );
                    },
                  );
                } else if (state is TaskError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
