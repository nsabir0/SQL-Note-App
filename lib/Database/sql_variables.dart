import 'dart:core';

class SqlVariable {
  static const String notesTable = 'notes';
  static const String column_id = 'id';
  static const String column_title = 'title';
  static const String column_age = 'age';
  static const String column_description = 'description';
  static const String column_email = 'email';

  static const String createNotesTable =
      "CREATE TABLE ${SqlVariable.notesTable} (${SqlVariable.column_id} INTEGER PRIMARY KEY AUTOINCREMENT, ${SqlVariable.column_title} TEXT NOT NULL, ${SqlVariable.column_age} INTEGER NOT NULL, ${SqlVariable.column_description} TEXT NOT NULL, ${SqlVariable.column_email} TEXT)";
}
