import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import 'todo_notifier.dart';

class TodoController {
  final WidgetRef ref;
  TodoController(this.ref);

  List<Todo> watchTodos() => ref.watch(todoProvider);

  void add(String description) =>
      ref.read(todoProvider.notifier).add(description);

  void remove(String id) => ref.read(todoProvider.notifier).remove(id);

  void update(String id, String newDescription) =>
      ref.read(todoProvider.notifier).update(id, newDescription);

  void toggleComplete(String id) =>
      ref.read(todoProvider.notifier).toggleComplete(id);
}
