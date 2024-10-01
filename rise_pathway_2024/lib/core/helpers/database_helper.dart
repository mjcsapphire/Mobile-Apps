import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:rise_pathway/core/helpers/helpers.dart';
import 'package:rise_pathway/core/tables/user_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.init();
  static Database? database;
  static Directory? dir;

  DatabaseHelper();

  DatabaseHelper.init();

  Future<Database> get fetchDatabase async {
    if (database != null) return database!;
    database = await _initDB('rise_pathway.db');
    return database!;
  }

  bool get isDatabaseInitialized => database != null;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    dir = await getApplicationDocumentsDirectory();
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await userTable(db: db);
  }

  Future<void> _onConfigure(Database db) async {
    db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> insertIntoDB(
      {required String tableName, required Map<String, dynamic> data}) async {
    try {
      final db = await fetchDatabase;
      final id = await db.insert(tableName, data);
      logger.d('Inserted Into $tableName with id $id Successfully');
    } catch (e) {
      logger.e(e);
    }
  }
}
