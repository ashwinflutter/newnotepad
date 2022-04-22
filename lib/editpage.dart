import 'package:flutter/material.dart';
import 'package:newnotepad/addnote.dart';
import 'package:newnotepad/dbhelper.dart';
import 'package:newnotepad/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:date_time_picker/date_time_picker.dart';

class editpage extends StatefulWidget {



  String name;String dd;int id;
  editpage(this.name,this.dd,this.id);

  @override
  _editpageState createState() => _editpageState();
}

class _editpageState extends State<editpage> {
  Database? db;

  TextEditingController name = TextEditingController();
  TextEditingController dd=TextEditingController();
  List<Map> userdata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String namee = widget.name;
    name.text = namee;

    getalldata();
  }

  void getalldata() {
    dbhelper().Forintializedataabase().then((value) {
      db = value;

      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return addnote();
                          },
                        ));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.pink,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        String newname = name.text;
                        String newdd=dd.text;

                        dbhelper().editdata(db!,newname,newdd,widget.id).then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return firstpage();
                            },
                          ));
                        });
                      },
                      child: Icon(
                        Icons.save,
                        color: Colors.brown,
                      ))
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    color: Colors.black26,
                    child: TextFormField(
                      controller: name,
                      maxLines: 15,
                      decoration: InputDecoration.collapsed(hintText: "title"),
                      style: TextStyle(fontSize: 30),
                    ),
                    height: theight * .75,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                    height: 40,
                    onPressed: () {

                    },
                    child: Icon(Icons.account_circle_rounded),
                    color: Colors.lightGreen),
              ],
            )
          ],
        ),
      ),
    );
  }
}

