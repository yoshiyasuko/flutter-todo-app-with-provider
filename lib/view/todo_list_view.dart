import 'package:flutter/material.dart';
import 'package:flutter_todo_app_with_provider/domain/todo_item.dart';
import 'package:flutter_todo_app_with_provider/view_model/todo_list_view_model.dart';
import 'package:provider/provider.dart';

class TodoListView extends StatelessWidget {
  final TodoListViewModel todoListViewModel = TodoListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App With Provider"),
      ),
      floatingActionButton:
          _buildFloatingActionButton(context, todoListViewModel),
      body: ChangeNotifierProvider(
        create: (context) => todoListViewModel,
        child: Consumer<TodoListViewModel>(
          builder: (context, viewModel, _) {
            return _buildTodoList(viewModel);
          },
        ),
      ),
    );
  }

  Widget _buildTodoList(TodoListViewModel viewModel) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return _buildTodoItem(context, viewModel.todoItems[index], index);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: viewModel.todoItems.length);
  }

  Widget _buildTodoItem(BuildContext context, TodoItem item, int index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ObjectKey(item.title),
      onDismissed: (direction) {
        todoListViewModel.deleteTodoItem(item.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("「${todoListViewModel.todoItems[index].title}」のタスクを削除しました。"),
          duration: const Duration(seconds: 3),
        ));
      },
      child: ListTile(title: Text(item.title)),
    );
  }

  Widget _buildFloatingActionButton(
      BuildContext context, TodoListViewModel viewModel) {
    return FloatingActionButton(
        onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                          appBar: AppBar(title: Text('新しいタスクを追加')),
                          body: TextField(
                            autofocus: true,
                            onSubmitted: (value) {
                              viewModel.createTodoItem(value);
                              Navigator.pop(context);
                            },
                            decoration: InputDecoration(
                                hintText: "タスクを入力してください",
                                contentPadding: const EdgeInsets.all(16.0)),
                          ))))
            },
        child: Icon(Icons.add));
  }
}
