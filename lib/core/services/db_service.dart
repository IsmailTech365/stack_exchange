import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/questions.dart';

class DBService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'questions.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE questions(
            id INTEGER PRIMARY KEY, 
            title TEXT, 
            body TEXT,
            tags TEXT,
            ownerName TEXT,
            viewCount INTEGER,
            answerCount INTEGER,
            score INTEGER,
            isAnswered INTEGER,
            creationDate TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> insertQuestion(Question question) async {
    final db = await database;
    await db.insert(
      'questions',
      question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Question>> getQuestions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('questions');
    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }
}
