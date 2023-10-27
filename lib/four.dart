import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offline_database/five.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main()
 {
   runApp(MaterialApp(home: four(),));
 }

 class four extends StatefulWidget {
   const four({super.key});

   static Directory?dir;
   static Database?database;

   @override
   State<four> createState() => _fourState();
 }

 class _fourState extends State<four> {

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  ImagePicker picker = ImagePicker();
  XFile? image;
  bool t=false;

  @override
  void initState() {
    permission();
    get();
  }


  permission()
  async {

    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }

    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/img1";
    print(path);

    four.dir=Directory(path);
    if( ! await four.dir!.exists())
      {
        four.dir!.create();
      }
  }


  get() async {

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

// open the database
     four.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT, image TEXT)');
        });

  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       resizeToAvoidBottomInset: false,

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
                     ],
                   );
                 },);

               }, child: Text("Choose")),

               ElevatedButton(onPressed:  () async {

                 String name=t1.text;
                 String contact=t2.text;

                 int r=Random().nextInt(100);
                 String img_name="${r}.png";
                 File f=File("${four.dir!.path}/${img_name}");
                 f.writeAsBytes( await image!.readAsBytes());


                 String sql="insert into student values(null,'$name','$contact','$img_name')";
                 four.database!.rawInsert(sql);
                 print(sql);

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
             child: (t==true)?Image.file(File(image!.path)):null,
           )
         ],
       ),
     );
   }
 }
