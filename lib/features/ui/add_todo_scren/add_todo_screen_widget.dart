import 'package:elementary/elementary.dart';
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: wm.date,
                        decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Due Date'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          // color: _selectedButton == 0 ? Colors.blue : Colors.grey,
                          onPressed: () {
                            wm.selectedPriority = Priority.high;
                            print(wm.selectedPriority);
                          },
                          child: Text('High'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            wm.selectedPriority = Priority.medium;
                            print(wm.selectedPriority);
                          },
                          child: Text('Medium'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            wm.selectedPriority = Priority.low;
                            print(wm.selectedPriority);
                          },
                          child: Text('Low'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        wm.addTodo(
                          TodoModel(
                            title: wm.title.text, 
                            description: wm.description.text, 
                            dueTime: wm.date.text, 
                            priority: wm.selectedPriority,
                          ),
                        );
                      },
                      child: const Text("Add new Todo"),
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
