import 'package:bloc_basic/shared/components/components.dart';
import 'package:bloc_basic/shared/cubit/cubit.dart';
import 'package:bloc_basic/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.instance(context).doneTasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}
