import 'dart:io';

import 'package:flutter_todo_app_with_provider/domain/table_todo_item.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'data_store.g.dart';

@UseMoor(tables: [TableTodoItem])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insert(String title) {
    return into(tableTodoItem)
        .insert(TableTodoItemCompanion.insert(title: title));
  }

  Future<List<TableTodoItemData>> get allTodoItems =>
      select(tableTodoItem).get();

  Future<int> updateTodoItem(int id, String title, bool isCompleted) {
    return (update(tableTodoItem)..where((it) => it.id.equals(id))).write(
        TableTodoItemCompanion.insert(
            title: title, isCompleted: Value(isCompleted)));
  }

  Future<int> deleteTodoItem(int id) {
    return (delete(tableTodoItem)..where((it) => it.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}
