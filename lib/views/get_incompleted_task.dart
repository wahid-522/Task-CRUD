import 'package:flutter/material.dart';
import 'package:flutter_b23_firebase/models/task.dart';
import 'package:flutter_b23_firebase/services/task.dart';
import 'package:provider/provider.dart';
class GetIncompletedTaskView extends StatelessWidget {
  const GetIncompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get In Completed Task")),
      body: StreamProvider.value(
        value: TaskServices().getInCompletedTask(),
        initialData: [Welcome(decription: '')],
        builder: (context, child) {
          List<Welcome> taskList = context.watch<List<Welcome>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].decripation.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
