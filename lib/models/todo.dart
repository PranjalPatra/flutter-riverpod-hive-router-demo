import 'package:hive_ce/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isCompleted;

  Todo({required this.id, required this.description, this.isCompleted = false});

  Todo copyWith({String? description, bool? isCompleted}) {
    return Todo(
      id: id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
