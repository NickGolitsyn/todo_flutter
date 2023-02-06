import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/main.dart';

import 'data/models/to_do_model/todo_model.dart';
import 'data/source/to_do_source/todo_source.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TodoLocalDataSource todoLocalDataSource = TodoLocalDataSource();

  Priority _selectedButton = Priority.none;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();

  Future<void> saveNewTodo(TodoModel todoModel) async {
    await todoLocalDataSource.saveTodo(todoModel);
  }

  Future<void> loadTodo() async {
    await todoLocalDataSource.loadTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Todo"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _date,
                decoration: InputDecoration(labelText: 'Due Date'),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime.now(), 
                    lastDate: DateTime(2100),
                  );
                  if (pickeddate != null) {
                    setState(() {
                      _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                    });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    // color: _selectedButton == 0 ? Colors.blue : Colors.grey,
                    onPressed: () => setState(() => {
                      _selectedButton = Priority.high,
                      print(_selectedButton)
                    }),
                    child: Text('High'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => {
                      _selectedButton = Priority.medium,
                      print(_selectedButton)
                    }),
                    child: Text('Medium'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => {
                      _selectedButton = Priority.low,
                      print(_selectedButton)
                    }),
                    child: Text('Low'),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  String title = _title.text;
                  String description = _description.text;
                  String date = _date.text;
                  await saveNewTodo(TodoModel(title: title, description: description, dueTime: date, priority: _selectedButton));
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: const Text('Add Todo'),
              )
            ]
          ),
        ),
      )
    );
  }
}