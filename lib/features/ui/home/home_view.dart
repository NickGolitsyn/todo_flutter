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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.navigateToAddTodoScreen,
        child: const Icon(Icons.add),
      ),
      body: EntityStateNotifierBuilder(
        listenableEntityState: wm.loading,
        builder: (context, bool? data) {
          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EntityStateNotifierBuilder(
                      listenableEntityState: wm.todoModelListEntity,
                      builder: (context, List<TodoModel>? todoModels) {
                        if (todoModels == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (todoModels.isEmpty) {
                          return const Center(
                            child: Text('You have no tasks'),
                          );
                        }

                        return Expanded(
                          child: ListView.builder(
                            itemCount: todoModels.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                                  // child: Slidable(
                                  //   endActionPane: ActionPane(
                                  //     motion: StretchMotion(),
                                  //     children: [
                                  //       SlidableAction(
                                  //         onPressed: doNothing,
                                  //         icon: Icons.delete,
                                  //         backgroundColor: Colors.red,
                                  //         borderRadius: BorderRadius.circular(12),
                                  //       )
                                  //     ],
                                  //   ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: (() {
                                        switch (todoModels[index].priority) {
                                          case Priority.high:
                                            return Colors.red[400];
                                          case Priority.medium:
                                            return Colors.yellow[400];
                                          case Priority.low:
                                            return Colors.green[400];
                                          case Priority.none:
                                            return Colors.grey[400];
                                        }
                                      }()),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                                      child: Column(children: [
                                        Text(
                                          todoModels[index].title,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          todoModels[index].description,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          todoModels[index].dueTime,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            wm.deleteTodo(index);
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ]),
                                    ),
                                  )
                                  // ),
                                  );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (data == true)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          );
        },
      ),
    );
  }
}
