import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqflite {
  static Database? _db;

  Future<Database?> get dB async {
    _db ??= await initialDB();
    return _db;
  }

  initialDB() async {
    String databasePath = await getDatabasesPath();
    String databaseName = "TimoDB.db";
    String path = join(databasePath, databaseName);
    Database? myDb = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return myDb;
  }

  deleteDB() async {
    String databasePath = await getDatabasesPath();
    String databaseName = "TimoDB.db";
    String path = join(databasePath, databaseName);
    await deleteDatabase(path);
  }

  final myTable = "fav";
  final id = "id";
  final title = "title";
  final String Image = "Image";
  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "$myTable"(
      "$title" TEXT NOT NULL,
      "$Image" TEXT NOT NULL,
      "$id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
      )
    ''');
    print("Create=======================");
  }

  // TODO DON'T FORGET TO INCREASE VERSION
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
      CREATE TABLE "new_fav"(
        "title" TEXT NOT NULL,
        "Image" TEXT NOT NULL,
        "id" INTEGER PRIMARY KEY AUTOINCREMENT
      )
  ''');

    await db.execute('''
    INSERT INTO "new_fav" ("title","Image","id")
    SELECT title,Image,id FROM "fav";
''');

    await db.execute('''
    DROP TABLE "fav"
''');

    await db.execute('''
    ALTER TABLE "new_fav" RENAME TO "fav";
''');
    print("onUpgrade Done");
  }

  // CRUD Operations
  // Create || INSERT
  insertData(String sql) async {
    Database? myDb = await dB;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  // Read
  readData(String sql) async {
    Database? myDb = await dB;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  // Update
  updateData(String sql) async {
    Database? myDb = await dB;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  // Delete
  deleteData(String sql) async {
    Database? myDb = await dB;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  // Shortcut
  myInsert(String table, Map<String, Object?> values) async {
    Database? myDb = await dB;
    int response = await myDb!.insert(table, values);
    return response;
  }

  // Read
  myRead(String table) async {
    Database? myDb = await dB;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  // Update
  myUpdate(String table, Map<String, Object?> values, String myWhere) async {
    Database? myDb = await dB;
    int response = await myDb!.update(table, values, where: myWhere);
    return response;
  }

  // Delete
  myDelete(String table, String myWhere) async {
    Database? myDb = await dB;
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }

  // Delete
  deleteTable(String table) async {
    Database? myDb = await dB;
    int response = await myDb!.delete(table);
    return response;
  }
}
