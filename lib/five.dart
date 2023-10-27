import 'dart:io';

import 'package:flutter/material.dart';
import 'package:offline_database/four.dart';
import 'package:offline_database/six.dart';

class five extends StatefulWidget {
  const five({super.key});

  @override
  State<five> createState() => _fiveState();
}

class _fiveState extends State<five> {

  List<Map> l=[];

  @override
  void initState() {

    String sql="select * from student";
    four.database!.rawQuery(sql).then((value) {
      l=value;
      print(l);
      setState(() {

      });

    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {

        String img_path="${four.dir!.path}/${l[index]['image']}";
        File f=File(img_path);

        return Card(
          child: ListTile(
            title: Text("${l[index]['name']}"),
            leading: CircleAvatar(
              backgroundImage: FileImage(f),
            ),
            
            trailing: Wrap(
              children: [
                IconButton(onPressed: () {

                  String sql="delete from student where id=${l[index]['id']}";
                  four.database!.rawDelete(sql);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return five();
                  },));

                }, icon: Icon(Icons.delete)),

                IconButton(onPressed: () {

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return six(l[index]);
                  },));
                }, icon: Icon(Icons.edit))
              ],
            ),
          ),
        );
      },),
    );
  }
}
