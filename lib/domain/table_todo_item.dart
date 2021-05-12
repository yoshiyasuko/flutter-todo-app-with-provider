import 'package:moor/moor.dart';

class TableTodoItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get memo => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}
