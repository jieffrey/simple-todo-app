import 'package:flutter/foundation.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    _todos.add(Todo(id: DateTime.now().toString(), title: title));
    notifyListeners();
  }

  void toggleTodoStatus(String id) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
