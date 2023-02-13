import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_wm.dart';

class AddTodoScreenWidget extends ElementaryWidget<IAddTodoWidgetModel> {
  const AddTodoScreenWidget({
    Key? key,
    WidgetModelFactory wmFactory = addTodoWidgetModelFactory,
  }) : super(key: key, wmFactory);

  @override
  Widget build(IAddTodoWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Todo"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EntityStateNotifierBuilder(
              listenableEntityState: wm.addTodoScreeenListenable,
              builder: (context, TodoModel? todoModels) {
                return Column(
                  children: [
                    //  TextFormField(
                    //   controller: wm.title,
                    //   decoration: InputDecoration(labelText: 'Title'),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please enter some text';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: wm.title,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: wm.description,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    //   child: TextField(
                    //     controller: wm.description,
                    //     decoration: const InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Description',
                    //     ),
                    //   ),
                    // ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                       child: TextField(
                        controller: wm.date,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Due Date'
                        ),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                            context: context, 
                            initialDate: DateTime.now(), 
                            firstDate: DateTime.now(), 
                            lastDate: DateTime(2100),
                          );
                          if (pickeddate != null) {
                            wm.date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        wm.addTodo(TodoModel(title: wm.title.text, description: wm.description.text, dueTime: wm.date.text, priority: Priority.low));
                      },
                      child: Text("Go back"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
