import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offline_database/five.dart';
import 'package:offline_database/four.dart';


class six extends StatefulWidget {

  Map l;
  six(this.l);

  @override
  State<six> createState() => _sixState();
}

class _sixState extends State<six> {

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;
  bool t=false;
  String img_name="";
  File ?file;

  @override
  void initState() {

    t1.text=widget.l['name'];
    t2.text=widget.l['contact'];
    img_name=widget.l['image'];


    String imgpath="${four.dir!.path}/${widget.l['image']}";
    file=File(imgpath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,

      appBar: AppBar(),

        body: Column(
          children: [
            TextField(
              controller: t1,
              decoration: InputDecoration(
                labelText: "Enter Name",
              ),
            ),

            TextField(
              controller: t2,
              decoration: InputDecoration(
                  labelText: "Enter Contact"
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {

                  showDialog(
                    barrierDismissible: false,
                    context: context, builder: (context) {
                    return AlertDialog(
                      title: Text("Choose Any One"),
                      actions: [
                        Row(children: [
                          TextButton(onPressed: () async {

                            image = await picker.pickImage(source: ImageSource.camera);
                            t=true;
                            Navigator.pop(context);
                            setState(() {

                            });

                          }, child: Text("Camera")),

                          TextButton(onPressed: () async {

                            image = await picker.pickImage(source: ImageSource.gallery);
                            t=true;
                            Navigator.pop(context);
                            setState(() {

                            });

                          }, child: Text("Gallery"))

                        ],)
                      ],);
                  },);

                }, child: Text("Choose")),


                ElevatedButton(onPressed:  () async {

                  String name=t1.text;
                  String contact=t2.text;

                 if(image != null)
                   {
                     File file1=File("${four.dir!.path}/${img_name}");
                     file1.delete();

                     int r=Random().nextInt(100);
                     img_name="${r}.png";
                     File f=File("${four.dir!.path}/${img_name}");
                     f.writeAsBytes( await image!.readAsBytes());
                     print("hello");

                     String sql="update student set name='$name', contact='$contact',image='$img_name' where id='${widget.l['id']}'";
                     four.database!.rawUpdate(sql);
                     print(sql);
                     setState(() {

                     });
                   }

                 setState(() {

                 });
                 
                }, child: Text("Add")),

                ElevatedButton(onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return five();
                  },));
                }, child: Text("View"))
              ],
            ),

            Container(
              margin: EdgeInsets.only(top: 30),
              height: 300,
              width: 300,
              color: Colors.black,
              child: (t==true)?Image.file(File(image!.path)):Image.file(file!),
            )
          ],
        )

    );
  }
}


//child: (t==true)?Image.file(File(image!.path)):null,