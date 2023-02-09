import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'home_wm.dart';

class HomeScreenWidget extends ElementaryWidget<IHomeWidgetModel> {
  const HomeScreenWidget({
    Key? key,
    WidgetModelFactory wmFactory = homeWidgetModelFactory,
  }) : super(key: key, wmFactory);

  @override
  Widget build(IHomeWidgetModel wm) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EntityStateNotifierBuilder(
              listenableEntityState: wm.todoModelListEntity,
              builder: (context, List<TodoModel>? todoModels) {
                if (todoModels == null) return Container();

                if (todoModels.isEmpty) {
                  return const Center(
                    child: Text('У вас нет задач'),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: todoModels.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text(todoModels[index].description),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
