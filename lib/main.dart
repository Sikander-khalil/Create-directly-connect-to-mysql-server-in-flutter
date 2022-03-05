import 'package:flutter/material.dart';
import 'package:sqlite/Databasehelper.dart';
import 'package:sql_conn/sql_conn.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp(),));


}




class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> connect(BuildContext ctx) async {
    debugPrint("Connecting...");
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("LOADING"),
            content: CircularProgressIndicator(),
          );
        },
      );
      await SqlConn.connect(
          ip: "192.168.10.8",
          port: "49170",
          databaseName: "sub_candidpro",
          username: "sa",
          password: "exapp");
      debugPrint("Connected!");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    debugPrint(res.toString());
  }

  Future<void> write(String query) async {
    debugPrint(" in write!");
    debugPrint(query);
    var res = await SqlConn.writeData(query);
    debugPrint(" after write!");
    debugPrint(res.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Sqlite'),),
      body: Center(
        child: Column(

          children: <Widget>[


             FlatButton(onPressed: () async{
               List<Map<String, Object?>>? queryrows=await DatabaseHelper.instance.queryAll();
               connect(context);
               print(queryrows);

             }, child: Text('insert')


             ),
            ElevatedButton(

                onPressed: () =>
                   // print("writing data"),

                write("INSERT INTO Student(StudentId, StudentName) VALUES(4,'Sikander')"),

                child: const Text("Write")),

            ElevatedButton(
                onPressed: () => SqlConn.disconnect(),
                child: const Text("Disconnect"))



          ],
        ),
      ),
    );
  }
}



