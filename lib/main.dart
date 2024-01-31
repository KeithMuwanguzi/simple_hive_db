import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/screens/todo.dart';
import 'package:todo_app/screens/todo_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TodoAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo App',
      theme: ThemeData(),
      home: FutureBuilder(
          future: Hive.openBox("todos"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(snapshot.error.toString()),
                  ),
                );
              } else {
                return const TodoPage();
              }
            } else {
              return const Scaffold();
            }
          }),
    );
  }

  @override
  void dispose() {
    Hive.box("todos").compact();
    Hive.close();
    super.dispose();
  }
}
