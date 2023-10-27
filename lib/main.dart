import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline_database/view_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main()
{
  runApp(MaterialApp(home: first(),
  debugShowCheckedModeBanner: false,));
}

class first extends StatefulWidget {
  const first({super.key});

  static Database?database;

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  @override
  void initState() {
    get();
  }


  get()
  async {

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

// open the database
    first. database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT,'
                  'email TEXT,password TEXT)');
        });

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
            labelText: "Enter Contact"
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

          String sql="insert into student values(null,'$name','$contact','$email','$password')";
          first.database!.rawInsert(sql);
            print(sql);
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
