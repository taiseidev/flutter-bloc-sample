import 'package:bloc_sample/blocs/todos/todos_bloc.dart';
import 'package:bloc_sample/blocs/todos/todos_event.dart';
import 'package:bloc_sample/blocs/todos/todos_state.dart';
import 'package:bloc_sample/extension/string_extension.dart';
import 'package:bloc_sample/models/todo.dart';
import 'package:bloc_sample/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosBloc>(
      create: (_) => TodosBloc(),
      child: const _TodoListBody(),
    );
  }
}

class _TodoListBody extends StatefulWidget {
  const _TodoListBody();

  @override
  State<_TodoListBody> createState() => _TodoListBodyState();
}

class _TodoListBodyState extends State<_TodoListBody> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<TodosBloc, TodosState>(
              builder: (context, state) {
                if (state.status == TodoStatus.inProgress) {
                  return const CircularProgressIndicator();
                }

                if (state.todo.isEmpty) {
                  return const Text('Todoがありません');
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: state.todo.length,
                    itemBuilder: (context, index) {
                      final todo = state.todo[index];

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          todosBloc.add(DeleteTodoEvent(todo.id));
                        },
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          var result = await await showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: const Text("削除しますか😢"),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text('閉じる'),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text('削除'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                          return Future.value(result);
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        ),
                        dismissThresholds: const {
                          DismissDirection.startToEnd: 0.5
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(todo.title),
                            subtitle: Row(
                              children: [
                                Text(todo.description),
                                const SizedBox(width: 16),
                                Text(
                                    todo.createdAt.toString().toCustomFormat()),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: const Text("todoを追加🗒"),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('タイトル'),
                          TextFormField(
                            controller: titleController,
                            validator: (value) {
                              if (value == null) {
                                return 'タイトルを入力してください';
                              }
                              return null;
                            },
                          ),
                          const Text('内容'),
                          TextFormField(
                            controller: descriptionController,
                            validator: (value) {
                              if (value == null) {
                                return '内容を入力してください';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('閉じる'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final id = getUuid();
                              final createdAt = DateTime.now();

                              todosBloc.add(AddTodoEvent(
                                Todo(
                                  id: id,
                                  title: titleController.text.trim(),
                                  description:
                                      descriptionController.text.trim(),
                                  createdAt: createdAt,
                                ),
                              ));

                              titleController.clear();
                              descriptionController.clear();

                              Navigator.pop(context);
                            }
                          },
                          child: const Text('追加'),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
