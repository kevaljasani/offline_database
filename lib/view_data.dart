import 'package:flutter/material.dart';
import 'package:offline_database/edit_data.dart';
import 'package:offline_database/main.dart';

class view_data extends StatefulWidget {
  const view_data({super.key});

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {

  List<Map> l=[];
  List<Map> l1=[];
  bool t=false;
  bool t1=false;

  @override
  void initState() {
    get();
  }

  get()
  {
    String sql="select * from student";
    first.database!.rawQuery(sql).then((value) {
      l=value;
      l1=l;
      print(l);
      t=true;

      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: (t1)?TextField(
          onChanged: (value) {

            l=l1.where((element) => element["name"].toString().contains(value)).toList();
            setState(() {

            });
          },
          autofocus: true,
          cursorColor: Colors.white,
        ):null,

        actions: [
          IconButton(onPressed: () {

            t1=!t1;
            setState(() {

            });

          }, icon: (t1)?Icon(Icons.close):Icon(Icons.search)),
        ],
      ),

      body: (t)?ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${l[index]['name']}""\t\t\t:-${l[index]['contact']}"),
              subtitle: Text("${l[index]['email']}""\n${l[index]['password']}"),
              trailing: Wrap(
                children: [
                  IconButton(onPressed: () {

                    String sql="delete from student where id=${l[index]['id']}";
                    first.database!.rawDelete(sql);

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return view_data();
                    },));
                    setState(() {

                    });
                  }, icon: Icon(Icons.delete)),


                  IconButton(onPressed: () {

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return edit_data(l[index]['id'],l[index]['name'],l[index]['contact'],
                          l[index]['email'],l[index]['password']);
                    },));
                  }, icon: Icon(Icons.edit))
                ],
              ),

            ),
          );
        },):CircularProgressIndicator()
    );

  }
}
