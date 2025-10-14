import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/todo_controller.dart';
import '../models/todo.dart';
import 'edit_todo_view.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TodoController(ref);
    final List<Todo> todos = controller.watchTodos();

    return Scaffold(
      appBar: AppBar(title: const Text('My Todos')),
      body: todos.isEmpty
          ? const Center(child: Text('No tasks yet. Add one.'))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, i) {
                final t = todos[i];
                return ListTile(
                  title: Text(
                    t.description,
                    style: TextStyle(
                      decoration: t.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: t.isCompleted,
                    onChanged: (_) => controller.toggleComplete(t.id),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTodoView(id: t.id),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.remove(t.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditTodoView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
