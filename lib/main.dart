import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/addTodo.dart';
import 'data/models/to_do_list_model/todo_list_model.dart';
import 'data/models/to_do_model/todo_model.dart';
import 'data/source/to_do_source/todo_source.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoLocalDataSource todoLocalDataSource = TodoLocalDataSource();

  Future<void> deleteAllTodo() async {
    await todoLocalDataSource.deleteAllTodo();
  }

  Future<void> deleteTodo(int index) async {
    await todoLocalDataSource.deleteTodo(index);
  }

  Future<void> saveNewTodo(TodoModel todoModel) async {
    await todoLocalDataSource.saveTodo(todoModel);
  }

  Future<TodoListModel?> loadTodos() async {
    TodoListModel? todo = await todoLocalDataSource.loadTodo();

    // await Future.delayed(const Duration(seconds: 2));

    return todo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todo'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTodo()),
            );
          },
          child: Icon(Icons.add),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              FutureBuilder(
                future: loadTodos(),
                builder: (context, AsyncSnapshot<TodoListModel?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return Container();
                      }

                      return Column(
                        children: [
                          for (int i = 0; i < snapshot.data!.todoListModel!.length; i++) ...[
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: doNothing,
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    )
                                  ],
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: (() {
                                      switch (snapshot.data!.todoListModel![i].priority) {
                                        case Priority.high:
                                          return Colors.red;
                                        case Priority.medium:
                                          return Colors.yellow;
                                        case Priority.low:
                                          return Colors.green;
                                        case Priority.none:
                                          return Colors.blue;
                                      }
                                    } ()),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                                    child: Column(
                                      children : [
                                        Text(snapshot.data!.todoListModel![i].title),
                                        Text(snapshot.data!.todoListModel![i].description),
                                        Text(snapshot.data!.todoListModel![i].dueTime),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await deleteTodo(i);
                                            setState(() {});
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
                      );
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.active) {}

                  return Container();
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  await deleteAllTodo();
                  setState(() {});
                },
                child: const Text('Delete all'),
              ),
            ],
          ),
        ));
  }
}

void doNothing(BuildContext context) {}