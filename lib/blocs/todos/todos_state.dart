import 'package:bloc_sample/models/todo.dart';
import 'package:equatable/equatable.dart';

enum TodoStatus {
  initial,
  inProgress,
  success,
  failure,
}

class TodosState extends Equatable {
  const TodosState({
    required this.todo,
    required this.status,
  });
  final List<Todo> todo;
  final TodoStatus status;

  @override
  List<Object> get props => [todo, status];
}
