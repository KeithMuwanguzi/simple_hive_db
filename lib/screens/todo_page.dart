import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/screens/new_todo.dart';
import 'package:todo_app/screens/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildListView()),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 280, 100, 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewTodo(),
                  ),
                );
              },
              child: const Text("New Todo"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
        valueListenable: Hive.box('todos').listenable(),
        builder: (context, todoBox, _) {
          return ListView.builder(
              itemCount: todoBox.length,
              itemBuilder: (context, index) {
                final todo = todoBox.getAt(index) as Todo;
                return ListTile(
                  title: Text(
                    todo.title,
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(todo.text),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          todoBox.deleteAt(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
