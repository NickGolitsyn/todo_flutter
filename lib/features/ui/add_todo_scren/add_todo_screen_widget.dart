import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: wm.title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: wm.description,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  errorBorder: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: wm.date,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Due Date'),
                onTap: wm.pickDate,
              ),
            ),
            EntityStateNotifierBuilder(
              listenableEntityState: wm.errorListenable,
              builder: (context, bool? data) {
                if (data == true) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Не все поля заполнены',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
            EntityStateNotifierBuilder<Priority>(
              listenableEntityState: wm.priorytiListenable,
              builder: (context, Priority? priority) {
                if (priority == null) return Container();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: wm.lowTodo,
                          child: Container(
                            color: priority != Priority.low ? Colors.yellow : Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                              child: Align(
                                child: Text(
                                  'Low',
                                  style: TextStyle(
                                    color: priority != Priority.low ? Colors.black : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: wm.mediumTodo,
                          child: Container(
                            color: priority != Priority.medium ? Colors.yellow : Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                              child: Align(
                                child: Text(
                                  'Medium',
                                  style: TextStyle(
                                    color: priority != Priority.medium ? Colors.black : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: InkWell(
                          onTap: wm.hightTodo,
                          child: Container(
                            color: priority != Priority.high ? Colors.yellow : Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                              ),
                              child: Align(
                                child: Text(
                                  'Hight',
                                  style: TextStyle(
                                    color: priority != Priority.high ? Colors.black : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: wm.addTodo,
              child: const Text("Add new Todo"),
            ),
          ],
        ),
      ),
    );
  }
}
