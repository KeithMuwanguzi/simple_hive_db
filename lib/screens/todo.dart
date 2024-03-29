import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String text;

  Todo({required this.title, required this.text});
}
