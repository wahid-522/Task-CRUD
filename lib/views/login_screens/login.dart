
import 'package:flutter/material.dart';
import 'package:flutter_b23_firebase/providers/user.dart';
import 'package:flutter_b23_firebase/services/auth.dart';
import 'package:flutter_b23_firebase/services/user.dart';
import 'package:flutter_b23_firebase/views/get_all_task.dart';
import 'package:flutter_b23_firebase/views/login_screens/profile.dart';
import 'package:flutter_b23_firebase/views/login_screens/register.dart';
import 'package:flutter_b23_firebase/views/login_screens/reset_password.dart';
import 'package:flutter_b23_firebase/views/priority_Task.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(controller: emailController),
          TextField(controller: pwdController),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
            onPressed: () async {
              if (emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Email cannot be empty.")),
                );
                return;
              }
              if (pwdController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Password cannot be empty.")),
                );
                return;
              }
              try {
                isLoading = true;
                setState(() {});
                await AuthServices()
                    .loginUser(
                  email: emailController.text,
                  password: pwdController.text,
                )
                    .then((val) async {
                  await UserServices().getUser(val.uid).then((
                      userData,
                      ) {
                    user.setUser(userData);
                  });
                  isLoading = false;
                  setState(() {});
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Message"),
                        content: Text(
                          "User has been logged in successfully",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetAllTaskView(),
                                ),
                              );
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
            child: Text("Login"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterView()),
              );
            },
            child: Text("Go to SignUp"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetPasswordView()),
              );
            },
            child: Text("Go to Reset Password"),
          ),
        ],
      ),
    );
  }
}
