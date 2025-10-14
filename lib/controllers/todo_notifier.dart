import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/todo.dart';

final _uuid = const Uuid();

class TodoNotifier extends Notifier<List<Todo>> {
  late final Box<Todo> _box;

  @override
  List<Todo> build() {
    _box = Hive.box<Todo>('todos_box');
    return _box.values.toList();
  }

  void add(String description) {
    final todo = Todo(id: _uuid.v4(), description: description);
    _box.put(todo.id, todo);
    state = [...state, todo];
  }

  void remove(String id) {
    _box.delete(id);
    state = state.where((t) => t.id != id).toList();
  }

  void update(String id, String newDescription) {
    final updated = [
      for (final t in state)
        if (t.id == id) t.copyWith(description: newDescription) else t,
    ];
    _box.put(id, updated.firstWhere((t) => t.id == id));
    state = updated;
  }

  void toggleComplete(String id) {
    final updated = [
      for (final t in state)
        if (t.id == id) t.copyWith(isCompleted: !t.isCompleted) else t,
    ];
    _box.put(id, updated.firstWhere((t) => t.id == id));
    state = updated;
  }
}

final todoProvider = NotifierProvider<TodoNotifier, List<Todo>>(
  TodoNotifier.new,
);
