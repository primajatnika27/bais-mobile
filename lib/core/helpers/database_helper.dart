import 'package:bais_mobile/data/models/form_data/task_report_form_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'database_bais.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE task_report (
            id INTEGER PRIMARY KEY,
            payload TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertTaskReport(TaskReportFormData data) async {
    final db = await database;
    await db.insert(
      'task_report',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getAllTaskReport() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('task_report');
    return List.generate(maps.length, (index) => maps[index]['payload']);
  }
}