import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/restaurant.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();
  static const String _tblFavorite = 'favorites';

  Future<String> getDatabasePath() async {
    return await getDatabasesPath();
  }

  Future<Database> _initializeDb() async {
    final path = await getDatabasePath();
    final dbPath = join(path, 'restaurants.db');

    var db = await openDatabase(
      dbPath,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tblFavorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL,
            address TEXT
          )
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(_tblFavorite, restaurant.toMap());
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblFavorite);

    return results.map((res) => Restaurant.fromMap(res)).toList();
  }

  Future<Restaurant?> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tblFavorite, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return Restaurant.fromMap(results.first);
    } else {
      return null;
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(_tblFavorite, where: 'id = ?', whereArgs: [id]);
  }
}