import 'package:bloc_sample/models/todo.dart';
import 'package:equatable/equatable.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodosEvent {
  const AddTodoEvent(this.todo);
  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class EditTodoEvent extends TodosEvent {
  const EditTodoEvent(this.prevTodoId, this.newTodo);
  final String prevTodoId;
  final Todo newTodo;

  @override
  List<Object> get props => [prevTodoId, newTodo];
}

class DeleteTodoEvent extends TodosEvent {
  const DeleteTodoEvent(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}
