import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'sql_variables.dart';
import 'package:notes_sql/Model/notes_model.dart';

class DatabaseHelper {
  static Database? _database;

//Checking if Database is null=================================================
  Future<Database?> get checkDB async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

//Intializing Database=================================================
  initDatabase() async {
    var filePath = await getDatabasesPath();
    var dbPath = join(filePath, 'notes.db');

    return await openDatabase(dbPath, version: 1, onCreate: createDatabase);
  }

//Creating database=================================================
  createDatabase(Database db, int version) async {
    await db.execute(SqlVariable.createNotesTable);
  }

//Inserting new Notes Data in database==========================================
  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await checkDB;
    await dbClient!.insert('notes', notesModel.toMap());
    return notesModel;
  }

//Read data from database=================================================
  Future<List<NotesModel>> getNotesList() async {
    var dbClient = await checkDB;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('notes');
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

//Deleting database=================================================
  Future deleteTableContent() async {
    var dbClient = await checkDB;
    return await dbClient!.delete(
      'notes',
    );
  }

//Updating database=================================================
  Future<int> updateQuantity(NotesModel notesModel) async {
    var dbClient = await checkDB;
    return await dbClient!.update(
      'notes',
      notesModel.toMap(),
      where: 'id = ?',
      whereArgs: [notesModel.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    var dbClient = await checkDB;
    return await dbClient!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    var dbClient = await checkDB;
    dbClient!.close();
  }
}
