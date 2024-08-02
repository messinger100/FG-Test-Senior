import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String name;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.name,
    required this.isCompleted,
  });

  @override
  List<Object> get props => [id, name, isCompleted];

  Task copyWith({
    String? id,
    String? name,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}