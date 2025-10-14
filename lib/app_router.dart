import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/todo_list_view.dart';
import 'views/edit_todo_view.dart';
import 'error_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TodoListView(),
      routes: [
        GoRoute(path: 'add', builder: (context, state) => const EditTodoView()),
        GoRoute(
          path: 'edit/:id',
          builder: (context, state) =>
              EditTodoView(id: state.pathParameters['id']),
        ),
      ],
    ),
  ],
);
