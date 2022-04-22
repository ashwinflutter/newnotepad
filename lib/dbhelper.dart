import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbhelper {
  Future<Database> Forintializedataabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demoo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'create table Contactbookk (id integer primary key autoincrement ,name Text ,dd DATETIME)');
    });

    return database;
  }

  Future<void> insertdata(Database database, String ename, DateTime selectedDate) async {
    String insert = "insert into Contactbookk (name,dd) values('$ename','$selectedDate')";
    int cnt = await database.rawInsert(insert);
    print(cnt);
  }

  Future<List<Map>> viewdata(Database database) async {
    String select = "select * from Contactbookk";
    List<Map> list = await database.rawQuery(select);
    print(list);
    return list;
  }

  Future<void> editdata(
      Database database, String newname, String newdd, int id) async {
    String update =
        "UPDATE Contactbook SET name='$newname',dd='$newdd' WHERE id='$id'";
    int cnnt = await database.rawUpdate(update);
    print(cnnt);
  }

  Future<void> deletedata(Database database, int id) async {
    String delete = "DELETE FROM Contactbook WHERE id=$id";
    int cnt = await database.rawDelete(delete);
    print(cnt);
    // return cnt;
  }
}
