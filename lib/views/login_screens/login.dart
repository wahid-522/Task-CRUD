import 'package:flutter/material.dart';
import 'package:flutter_b23_firebase/services/auth.dart';
import 'package:flutter_b23_firebase/views/login_screens/register.dart';
import 'package:flutter_b23_firebase/views/login_screens/reset_password.dart';
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
     return Scaffold(
       appBar: AppBar(
         title: Text(" Login ", style: TextStyle(
           fontWeight: FontWeight.bold
         ),),
         leading: IconButton(onPressed: (){
           Navigator.pop(context);
         }, icon: Icon(Icons.arrow_back)),
         centerTitle: true,
       ),
       body: Column(
         children: [
           TextField( controller: emailController),
           TextField(controller: pwdController),
           SizedBox(height: 20,),
           isLoading ? Center(child: CircularProgressIndicator())
               :ElevatedButton(onPressed: () async {
               if(emailController.text.isEmpty)  {
                 ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text("Email Cannot be Empty ")));
                 return;
               }
               if(pwdController.text.isEmpty){
                 ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text("Password Cannot be Empty")));
                 return;
               }
               try{
                 isLoading = true;
                 setState(() { });
                 await AuthServices()
                 .loginUser(
                     email: emailController.text,
                     password: pwdController.text
                 )
                 .then((val){
                   isLoading = false;
                   setState(() {});
                   showDialog(
                       context: context,
                       builder: (context) {
                     return AlertDialog(
                       title: Text("Message"),
                       content: Text(
                           "User has been login Successfully"),
                       actions: [
                         TextButton(
                             onPressed: (){},
                             child: Text("Okay"))
                       ],
                     );
                   });
                 });
               }catch(e){
                 isLoading = false;
                 setState(() {});
                 ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(e.toString())));
               }
           },
               child: Text("Login"),
           ),
           SizedBox(height: 20,),
           ElevatedButton(
               onPressed: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => RegisterView()),
                 );
               },
               child: Text("SignUp")),
           SizedBox(height: 20,),
           ElevatedButton(
               onPressed: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => ResetPasswordView()),
                 );
               },
               child: Text("Rest password")),
         ],
       ),
     );
   }
}
