import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    final controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text(
          '📝 Cute To-Do',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: todoProvider.todos.isEmpty
                ? const Center(
                    child: Text(
                      '🌸 Belum ada tugas, tambah dulu yuk!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: todoProvider.todos.length,
                    itemBuilder: (context, index) {
                      final todo = todoProvider.todos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: todo.isDone
                                ? Colors.green[200]
                                : Colors.pink[200],
                            child: Text(
                              todo.isDone ? "✅" : "🐻",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              fontSize: 18,
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: todo.isDone
                                  ? Colors.grey
                                  : Colors.black87,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                context.read<TodoProvider>().removeTodo(todo),
                          ),
                          onTap: () =>
                              context.read<TodoProvider>().toggleTodoStatus(todo),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.pink[300],
        icon: const Icon(Icons.add),
        label: const Text("Tambah"),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text("🌼 Tambah Tugas Baru"),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Tulis tugasmu di sini...",
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Batal"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context.read<TodoProvider>().addTodo(controller.text);
                      Navigator.pop(context);
                      controller.clear();
                    }
                  },
                  child: const Text("Tambah"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
