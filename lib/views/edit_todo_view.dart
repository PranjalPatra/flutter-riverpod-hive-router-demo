import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/todo_controller.dart';
import '../controllers/todo_notifier.dart';
import '../models/todo.dart';

class EditTodoView extends ConsumerStatefulWidget {
  final String? id;
  const EditTodoView({super.key, this.id});

  @override
  ConsumerState<EditTodoView> createState() => _EditTodoViewState();
}

class _EditTodoViewState extends ConsumerState<EditTodoView> {
  late final TextEditingController _controller;
  Todo? _editing;

  @override
  void initState() {
    super.initState();
    final todos = ref.read(todoProvider);
    _editing = todos.where((t) => t.id == widget.id).cast<Todo?>().firstOrNull;
    _controller = TextEditingController(text: _editing?.description ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final controller = TodoController(ref);
    if (_editing == null) {
      controller.add(text);
    } else {
      controller.update(_editing!.id, text);
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editing != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Todo' : 'Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'What do you need to do?',
              ),
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _save,
              child: Text(isEdit ? 'Update' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
