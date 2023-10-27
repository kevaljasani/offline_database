import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main()
async {

  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  var box = await Hive.openBox('student');

  runApp(MaterialApp(home: hive(),));
}


class hive extends StatefulWidget {
  const hive({super.key});

  @override
  State<hive> createState() => _hiveState();
}

class _hiveState extends State<hive> {

  int a=0;
  Box box=Hive.box('student');

  @override
  void initState() {
    a=box.get('student')??0;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: Column(
        children: [
          Center(
            child: Text("A :- ${a}",style: TextStyle(fontSize: 50),),
          ),

          ElevatedButton(onPressed: () {

            a++;
            box.put('student', a);
            setState(() {

            });
          }, child: Text("Submit"))
        ],
      ),
    );
  }
}
