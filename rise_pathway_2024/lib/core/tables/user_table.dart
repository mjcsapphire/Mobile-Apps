import 'package:sqflite/sqflite.dart';

Future<void> userTable({
  required Database db,
}) async {
  await db.execute('''
   CREATE TABLE IF NOT EXISTS users (
    id INTEGER,
    mobile_app_profile_pic TEXT,
    firstname TEXT,
    surname TEXT,
    user_email TEXT,
    paid TEXT,
    riseSound TEXT,
    riseImage TEXT,
    mood TEXT,
    rises_day INTEGER,
    rises_week INTEGER,
    rises_month INTEGER,
    challenges_day INTEGER,
    challenges_week INTEGER,
    challenges_month INTEGER,
    health_pathway INTEGER,
    relationships_pathway INTEGER,
    adaptation_pathway INTEGER,
    personal_pathway INTEGER,
    wisdom_pathway INTEGER,
    coping_pathway INTEGER,
    engagement_pathway INTEGER,
    emotions_pathway INTEGER,
    identity_pathway INTEGER,
    decision_pathway INTEGER,
    created_at TEXT,
    updated_at TEXT
);
    ''');
}
