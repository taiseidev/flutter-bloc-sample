import 'package:bloc_sample/blocs/todos/todos_event.dart';
import 'package:bloc_sample/blocs/todos/todos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(const TodosState(todo: [], status: TodoStatus.initial)) {
    // 追加
    on<AddTodoEvent>(
      (event, emit) async {
        emit(TodosState(todo: state.todo, status: TodoStatus.inProgress));
        await Future<void>.delayed(const Duration(seconds: 1));
        // repositoryから取得したtodoを追加して返却
        return emit(
          TodosState(
            todo: [...state.todo, event.todo],
            status: TodoStatus.success,
          ),
        );
      },
    );

    // 編集
    on<EditTodoEvent>(
      (event, emit) async {
        emit(TodosState(todo: state.todo, status: TodoStatus.inProgress));
        // idに一致するtodoのインデックスを取得
        final prevIndex = state.todo.indexWhere(
          (todo) => todo.id == event.prevTodoId,
        );

        // 現在の状態からidに一致するtodoを削除して新しいtodoを追加
        final todos = [
          ...state.todo
            ..removeAt(prevIndex)
            ..insert(prevIndex, event.newTodo)
        ];

        await Future<void>.delayed(const Duration(seconds: 1));
        // repositoryのメソッドを叩いてtodoを更新

        return emit(
          TodosState(
            todo: todos,
            status: TodoStatus.success,
          ),
        );
      },
    );

    // 削除
    on<DeleteTodoEvent>(
      (event, emit) async {
        emit(TodosState(todo: state.todo, status: TodoStatus.inProgress));
        // idに一致するtodoを削除してtoto一覧を返却
        final todos = [
          ...state.todo..removeWhere((todo) => todo.id == event.id),
        ];

        await Future<void>.delayed(const Duration(seconds: 1));
        // repositoryのメソッドを叩いてtodoを更新
        return emit(
          TodosState(
            todo: todos,
            status: TodoStatus.success,
          ),
        );
      },
    );
  }
}
