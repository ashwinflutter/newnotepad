import 'package:flutter/material.dart';
import 'package:newnotepad/dbhelper.dart';
import 'package:newnotepad/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:date_time_picker/date_time_picker.dart';


class addnote extends StatefulWidget {
  const addnote({Key? key}) : super(key: key);

  @override
  _addnoteState createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
 String date = "";
  DateTime selectedDate = DateTime.now();

  Database? db;

  TextEditingController name = TextEditingController();
TextEditingController dd=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper().Forintializedataabase().then((value) {
      db = value;

    });
    setState(() {});
  }

  String getdat = "";

  @override
  Widget build(BuildContext context) {

    double theight = MediaQuery.of(context).size.height;

    return Scaffold(
   //  backgroundColor: Colors.brown.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 36,
            ),
            Container(
              color: Colors.amber.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return firstpage();
                          },
                        ));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.pink,
                      )),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 38,
                      width: 110,
                      color: Colors.lightGreen,
                      child: Text(
                        "Time",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {

                        String ename = name.text;

                        // dd.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        // String edd=dd.text;

                        dbhelper().insertdata(db!,ename,selectedDate).then((value) {
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


            TextField(
              controller: dd,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
         SizedBox(
              height: 36,
            ),
            Form(
              child: Column(
                children: [
                  Container(
               //     color: Colors.black26,
                    child: TextFormField(
                      controller: name,
                      maxLines: 15,
                      decoration: InputDecoration.collapsed(hintText:"Title",),
                      style: TextStyle(fontSize: 20),
                    ),
                    height: theight * .60,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        dd.text="${selectedDate.day}""/""${selectedDate.month}""/""${selectedDate.year}";
      });
  }
}
