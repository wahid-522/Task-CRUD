import 'package:flutter/material.dart';
import 'package:flutter_b23_firebase/models/task.dart';
import 'package:flutter_b23_firebase/services/task.dart';

class UpdateTaskView extends StatefulWidget {
  final Welcome model;

  UpdateTaskView({super.key, required this.model});

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    titleController = TextEditingController(
      text: widget.model.title.toString(),
    );
    descriptionController = TextEditingController(
      text: widget.model.decripation.toString(),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Task")),
      body: Column(
        children: [
          TextField(controller: titleController),
          TextField(controller: descriptionController),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
            onPressed: () async {
              if (titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Title cannot be empty.")),
                );
                return;
              }
              if (descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Description cannot be empty.")),
                );
                return;
              }

              try {
                isLoading = true;
                setState(() {});
                await TaskServices()
                    .updateTask(
                  Welcome(
                    title: titleController.text,
                    decripation: descriptionController.text,
                    docId: widget.model.docId.toString(), decription: '',
                  ),
                )
                    .then((val) {
                  isLoading = false;
                  setState(() {});
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Message"),
                        content: Text(
                          "Task has been updated successfully",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text("Okay"),
                          ),
                        ],
                      );
                    },
                  );
                });
              } catch (e) {
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Text("Update Task"),
          ),
        ],
      ),
    );
  }
}