import 'package:flutter/material.dart';
import 'package:flutter_b23_firebase/models/priority.dart';
import 'package:flutter_b23_firebase/services/priority_services.dart';
import 'package:flutter_b23_firebase/views/create_priority.dart';
import 'package:flutter_b23_firebase/views/priority_Task.dart';
import 'package:flutter_b23_firebase/views/update_priority.dart';
import 'package:provider/provider.dart';

class GetAllPrioritiesView extends StatelessWidget {
  const GetAllPrioritiesView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Get All Priorities")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePriorityView()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriorities(),
        initialData: [PriorityModel()],

        builder: (context, child) {
          List<PriorityModel> priorityList = context
              .watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.category),
                title: Text(priorityList[i].name.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        try {
                          await PriorityServices()
                              .deletePriority(priorityList[i])
                              .then((val) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Priority has been deleted successfully",
                                ),
                              ),
                            );
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdatePriorityView(model: priorityList[i]),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PriorityTaskView(model: priorityList[i] )));
                    }, icon: Icon(Icons.arrow_forward, color: Colors.blue,))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}