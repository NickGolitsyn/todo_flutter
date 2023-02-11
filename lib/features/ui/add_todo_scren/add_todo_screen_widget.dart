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
                    Text('Hello'),
                    ElevatedButton(
                      onPressed: () {},
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
