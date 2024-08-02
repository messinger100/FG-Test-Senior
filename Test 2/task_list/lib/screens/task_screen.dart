import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc.dart';
import '../blocs/task_event.dart';
import '../blocs/task_state.dart';
import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  TaskScreenState createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen> {
  final TextEditingController taskController = TextEditingController(); //Campo de texto.

  @override
  void initState() {
    super.initState();
    // Carga las tareas al inicializar la pantalla.
    BlocProvider.of<TaskBloc>(context).add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0), //Espaciado alrededor del campo de texto.
            child: TextField(
              controller: taskController, //Campo de texto
              decoration: InputDecoration(
                labelText: 'Nueva Tarea',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addTask, //Llama a addTask cuando se presiona el botón.
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoadSuccess) {
                  // Muestra la lista de tareas si la carga fue exitosa.
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index]; //Tarea actual en la lista.
                      return ListTile(
                        title: Text(task.name),
                        leading: Checkbox(
                          value: task.isCompleted, //Marca la casilla si la tarea está completada.
                          onChanged: (_) {
                            //Llama a ToggleTaskCompletion cuando se cambia el estado del checkbox.
                            BlocProvider.of<TaskBloc>(context).add(ToggleTaskCompletion(task.id));
                          },
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Llama a RemoveTask cuando se presiona el botón de eliminar.
                            BlocProvider.of<TaskBloc>(context).add(RemoveTask(task.id));
                          },
                        ),
                      );
                    },
                  );
                } else if (state is TaskLoadFailure) {
                  //Muestra un mensaje de error si la carga de tareas falló.
                  return const Center(child: Text('Error al cargar las tareas'));
                } else {
                  //Muestra un indicador (loading) mientras se están cargando las tareas.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void addTask() {
    final taskName = taskController.text; //Obtiene el nombre de la tarea desde el campo de texto.
    if (taskName.isNotEmpty) {
      //Crea una nueva tarea y la añade a la lista.
      final task = Task(id: DateTime.now().toString(), name: taskName, isCompleted: false);
      BlocProvider.of<TaskBloc>(context).add(AddTask(task));
      taskController.clear(); //Limpia el campo de texto después de añadir la tarea.
    }
  }
}
