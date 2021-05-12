import 'package:flutter_todo_app_with_provider/domain/data_store.dart';
import 'package:flutter_todo_app_with_provider/domain/todo_item.dart';

class DataRepository {
  static final DataRepository _instance = new DataRepository._internal();

  factory DataRepository() {
    return _instance;
  }

  DataRepository._internal();

  final _database = MyDatabase();

  Future<List<TodoItem>> getAllTodoItems() async {
    List<TodoItem> result = [];
    List<TableTodoItemData> recordList = await _database.allTodoItems;
    recordList.forEach((element) {
      result.add(TodoItem(
          element.id, element.title, element.memo, element.isCompleted));
    });
    return result;
  }

  Future<void> updateTodoItem(TodoItem item) async {
    await _database.updateTodoItem(
        item.id, item.title, item.memo, item.isCompleted);
  }

  Future<void> deleteTodoItem(int id) async {
    await _database.deleteTodoItem(id);
  }
}
