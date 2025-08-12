import 'package:flutter/material.dart';
import 'package:flutter_b23_firebase/models/priority.dart';
import 'package:flutter_b23_firebase/services/priority_services.dart';

class UpdatePriorityView extends StatefulWidget {
  final PriorityModel model;

  const UpdatePriorityView({super.key, required this.model});

  @override
  State<UpdatePriorityView> createState() => _UpdatePriorityViewState();
}

class _UpdatePriorityViewState extends State<UpdatePriorityView> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.model.name);
  //  print("Name Controller: $nameController");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Update Priority")),
      body: Column(
        children: [
          TextField(controller: nameController),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Name Cannot be Empty")),
                      );
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await PriorityServices()
                          .updatePriority(
                            PriorityModel(
                              docId: widget.model.docId.toString(),
                              name: nameController.text,
                            ),
                          )
                          .then((val) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("message "),
                                  content: Text(
                                    "Priority has been Update successfully",
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
                  child: Text("Update Priority"),
                ),
        ],
      ),
    );
  }
}
