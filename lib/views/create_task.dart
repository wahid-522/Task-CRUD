import 'package:flutter/material.dart';
import 'package:flutter_b23_firebase/models/priority.dart';
import 'package:flutter_b23_firebase/models/task.dart';
import 'package:flutter_b23_firebase/providers/user.dart';
import 'package:flutter_b23_firebase/services/priority_services.dart';
import 'package:flutter_b23_firebase/services/task.dart';
import 'package:provider/provider.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController= TextEditingController();
  TextEditingController descriptionController= TextEditingController();
  bool isLoading = false;
  List<PriorityModel>priorityList =[];
  PriorityModel? _selectedPriority;

  @override
  void initState() {
    // TODO: implement initState
    PriorityServices().getAllPriorities().first.then((val){
      priorityList = val;
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>
      (context);
    return Scaffold(
      appBar: AppBar(title: Text("create task "),),
      body: Column(
        children: [
          TextField(controller: titleController),
          TextField(controller: descriptionController,),
          SizedBox(height: 20,),
          DropdownButton(items: priorityList.map((e){
            return DropdownMenuItem(value: e, child: Text(e.name.toString()));
          }).toList(),
              isExpanded: true,
              value: _selectedPriority,
              hint: Text("Select Priority"),
              onChanged: (val){
            _selectedPriority = val;
            setState(() {});
              }),
          SizedBox(height: 20,),
          isLoading ? Center(child: CircularProgressIndicator())
          : ElevatedButton(onPressed: () async {
            if (titleController.text.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title cannot be empty")),);
              return;
            }
            if (descriptionController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Description cannot be empty")));
              return;
            }
            try{
              isLoading= true;
              setState(() {});
              await TaskServices().createTask(Welcome(
                title: titleController.text,
                decripation: descriptionController.text,
                  isCompleted: false,
                userID: user.getUser().docId.toString(),
                priorityID: _selectedPriority!.docId.toString(),
                creatAt: DateTime.now().millisecondsSinceEpoch, decription: '',
              )
              )
                  .then((val){
                isLoading=false;
                setState(() {});
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Message"),
                        content: Text("Task has been created successfully"),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, child: Text("okay"),)
                        ],
                      );
                    });
                });
            }
            catch(e){
              isLoading =false;
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Create Task"))
        ],
      ),
    );
  }
}
