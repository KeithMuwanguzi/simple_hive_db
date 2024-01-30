import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/screens/todo.dart';

class NewTodo extends StatelessWidget {
  const NewTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<State>();
    final title = TextEditingController();
    final text = TextEditingController();

    void addTodo(Todo todo) {
      final todoBox = Hive.box("todos");
      todoBox.add(todo);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Todo"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 30, 60, 10),
          child: Column(
            children: [
              const Text(
                "Create New Todo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text(
                        "Todo Title",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text(
                        "Todo Text",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100, 30, 100, 10),
                      child: ElevatedButton(
                        onPressed: () {
                          final newTodo =
                              Todo(title: title.text, text: text.text);
                          addTodo(newTodo);
                        },
                        child: const Text("Add Todo"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
