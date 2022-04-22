import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newnotepad/addnote.dart';
import 'package:newnotepad/dbhelper.dart';
import 'package:newnotepad/editpage.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: firstpage(),
  ));
}

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  _firstpageState createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  Database? db;
  List<Map> userdata = [];
List<Map>  searchlist=[];


  bool status = false;
  bool search=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlldata();
  }

  void getAlldata() {
    dbhelper().Forintializedataabase().then((value) {
      db = value;
      setState(() {});
      dbhelper().viewdata(db!).then((listofmap) {
        userdata = listofmap;
        searchlist = listofmap;

        setState(() {
          status = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status
          ? ListView.builder(
        itemCount: search? searchlist.length : userdata.length,
        itemBuilder: (context, index) {
          Map mm=search?searchlist[index]:userdata[index];
          return ListTile(
            onTap: () {

              String name = "${mm['name']}";
              String dd="$mm['dd']";
              int id = mm['id'];

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AlertDialog(
                    title: Text("Do You Want To EDIT or DELETE"),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return editpage(name,dd,id);
                                  },
                                ));
                          },
                          child: Text("EDIT")),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);

                            dbhelper().deletedata(db!,id).then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return firstpage();
                              },));
                            });
                          },
                          child: Text("DELETE"))
                    ],
                  );
                },
              ));
            },subtitle: Text("${mm['dd']}"),
            textColor: Colors.black,
            title: Text("${mm['name']}"),
          );
        },
            )
          : Center(child: CircularProgressIndicator()),
  //    backgroundColor: Colors.brown.shade200,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return addnote();
            },
          ));
        },
        child: Icon(Icons.add_box),
      ),
      appBar: search
          ? AppBar(
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              if (value != "") {
                searchlist = [];
                for (int i = 0; i < userdata.length; i++) {
                  String name = "${userdata[i]['name']}";
                  if (name
                      .toLowerCase()
                      .toString()
                      .contains(value.toLowerCase().toString())) {
                    searchlist.add(userdata[i]);
                    print(searchlist);
                  }
                }
              } else {
                searchlist = userdata;
                setState(() {});
              }
            });
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  search = false;
                });
              },
              icon: Icon(Icons.close))
        ],
      )
          : AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  search = true;
                });
              },
              icon: Icon(Icons.search_off))
        ],
        title: Text("Contactbook"),
      ),
    );
  }
}
