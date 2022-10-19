import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:bloc_basic/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:bloc_basic/modules/done_tasks/done_tasks_screen.dart';
import 'package:bloc_basic/modules/new_tasks/new_tasks_screen.dart';
import 'package:bloc_basic/shared/components/components.dart';
import 'package:bloc_basic/shared/cubit/cubit.dart';
import 'package:bloc_basic/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if(state is AppInsertDatabaseState){
            // changeBottomSheetState(
            //     isShow: false, icon: Icons.edit);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit appCubit = AppCubit.instance(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                appCubit.titles[appCubit.currentIndex],
              ),
            ),
            body: AnimatedConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => appCubit.screens[appCubit.currentIndex],
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async{
                if (appCubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    await appCubit.insertToDatabase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text,
                    );

                  }
                } else {
                  scaffoldKey.currentState?.showBottomSheet(
                    (context) => Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(
                        20.0,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'title must not be empty';
                                }

                                return null;
                              },
                              label: 'Task Title',
                              prefix: Icons.title,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: timeController,
                              type: TextInputType.datetime,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                  print(value.format(context));
                                });
                              },
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'time must not be empty';
                                }

                                return null;
                              },
                              label: 'Task Time',
                              prefix: Icons.watch_later_outlined,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: dateController,
                              type: TextInputType.datetime,
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2021-05-03'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'date must not be empty';
                                }

                                return null;
                              },
                              label: 'Task Date',
                              prefix: Icons.calendar_today,
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  ).closed.then((value) {
                    appCubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  appCubit.changeBottomSheetState(
                      isShow: true, icon: Icons.add);
                }
              },
              child: Icon(
                appCubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: appCubit.currentIndex,
              onTap: (index) {
                appCubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
