import 'package:flutter/material.dart';
import 'package:offline_database/view_data.dart';
import 'package:offline_database/main.dart';

class edit_data extends StatefulWidget {

  int id;
  String name;
  String contact;
  String email;
  String password;

  edit_data(this.id,this.name,this.contact,this.email,this.password);

  @override
  State<edit_data> createState() => _edit_dataState();
}

class _edit_dataState extends State<edit_data> {
  
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();
  TextEditingController t4=TextEditingController();

  @override
  void initState() {

    t1.text=widget.name;
    t2.text=widget.contact;
    t3.text=widget.email;
    t4.text=widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: Column(children: [
        TextField(
          controller: t1,
          decoration: InputDecoration(
              labelText: "Enter Name "
          ),
        ),

        TextField(
            controller: t2,
            decoration:InputDecoration(
                labelText: "Enter Contect"
            )
        ),

        TextField(
          controller: t3,
          decoration: InputDecoration(
              labelText: "Enter Email"
          ),
        ),

        TextField(
          controller: t4,
          decoration: InputDecoration(
              labelText: "Enter Password"
          ),
        ),


        ElevatedButton(onPressed: () {

          String name=t1.text;
          String contact=t2.text;
          String email=t3.text;
          String password=t4.text;

          String sql="update student set name='$name',contact='$contact' ,email='$email' ,password='$password' where id='${widget.id}'";
          first.database!.rawUpdate(sql);
          setState(() {

          });
        }, child: Text("Submit")),



        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return view_data();
          },));

        }, child: Text("View"))

      ],),


    );
  }
}
