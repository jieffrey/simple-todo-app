import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoProvider>().todos;
    final doneTodos = todos.where((t) => t.isDone).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Completed Tasks")),
      body: doneTodos.isEmpty
          ? const Center(child: Text("No tasks completed yet."))
          : ListView.builder(
              itemCount: doneTodos.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text(doneTodos[i].title),
              ),
            ),
    );
  }
}
