import 'dart:io';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/models/to_do_model/todo_model.dart';
import 'package:todo/features/ui/add_todo_scren/add_todo_wm.dart';
import 'package:flutter/cupertino.dart' as cu;

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
                  labelText: 'Title*',
                ),
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
                      'Title cannot me empty',
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
            // if (Platform.isIOS) {
            //   // DateTime dateTime = initialDate;
            //   await cu.showCupertinoModalPopup<DateTime>(
            //     context: context, 
            //     builder: (context) => Container(
            //       height: 216, 
            //       padding: const EdgeInsets.only(top: 6.0),
            //       margin: EdgeInsets.only(
            //         bottom: MediaQuery.of(context).viewInsets.bottom,
            //       ),
            //       color: AppTheme.of(context).bg.menu,
            //       child: cu.Column(
            //         mainAxisSize: cu.MainAxisSize.min,
            //         children: [
            //           Expanded(
            //             child: cu.CupertinoTheme(
            //               data: const cu.CupertinoThemeData(
            //                 textTheme: cu.CupertinoTextThemeData(
            //                   dateTimePickerTextStyle: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 16,
            //                   ),
            //                 ),
            //               ),
            //             child: cu.CupertinoDatePicker(
            //               backgroundColor: AppTheme.of(context).bg.menu,
            //               initialDateTime: initialDate,
            //               onDateTimeChanged: (dt) => dateTime = dt,
            //               maximumDate: lastDate,
            //               minimumDate: firstDate,
            //               mode: cu.CupertinoDatePickerMode.date,
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            //           child: SizedBox(
            //             height: 48,
            //             child: AppButton.primary(
            //               onPressed: Navigator.of(context).pop,
            //               size: AppButtonsSize.big,
            //               child: const Text(
            //                 'Готово',
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
            // return dateTime;
            // }
            EntityStateNotifierBuilder<Priority>(
              listenableEntityState: wm.priorytiListenable,
              builder: (context, Priority? priority) {
                if (priority == null) return Container();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: InkWell(
                          onTap: wm.highTodo,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
                              color: priority != Priority.high ? Colors.indigo[100] : Colors.indigo,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Align(
                                child: Text(
                                  'High',
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
                    Expanded(
                      child: InkWell(
                        onTap: wm.mediumTodo,
                        child: Container(
                          color: priority != Priority.medium ? Colors.indigo[100] : Colors.indigo,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
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
                    Expanded(
                      child: InkWell(
                        onTap: wm.lowTodo,
                        child: Container(
                          color: priority != Priority.low ? Colors.indigo[100] : Colors.indigo,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: wm.noneTodo,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)),
                              color: priority != Priority.none ? Colors.indigo[100] : Colors.indigo,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Align(
                                child: Text(
                                  'None',
                                  style: TextStyle(
                                    color: priority != Priority.none ? Colors.black : Colors.white,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: wm.addTodo,
                child: const Text("Add new Todo"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
