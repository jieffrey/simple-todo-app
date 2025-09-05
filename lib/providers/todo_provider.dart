import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

void addTodo(String title) {
  _todos.add(Todo(
    id: DateTime.now().toString(), // id wajib
    title: title,
  ));
  notifyListeners();
}


  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void toggleTodoStatus(Todo todo) {
  final index = _todos.indexOf(todo);
  if (index != -1) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }
}


  List<Todo> get completedTodos =>
      _todos.where((todo) => todo.isDone).toList();
}
