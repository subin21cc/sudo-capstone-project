import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_database.g.dart';

/// Generic key-value table. Hosts app-level small values that don't
/// warrant their own schema (locale, onboarding flags, etc.). As Stage 4
/// adds feature data, real tables (DietEntries, ExerciseSessions, …)
/// land here too.
class AppKeyValues extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{key};
}

@DriftDatabase(tables: <Type>[AppKeyValues])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'oncare'));

  /// Use in tests:
  ///   `AppDatabase.forTesting(NativeDatabase.memory())`
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  Future<void> putValue(String key, String value) {
    return into(appKeyValues).insertOnConflictUpdate(
      AppKeyValuesCompanion.insert(key: key, value: value),
    );
  }

  Future<String?> readValue(String key) async {
    final row = await (select(
      appKeyValues,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> deleteValue(String key) {
    return (delete(appKeyValues)..where((t) => t.key.equals(key))).go();
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}, name: 'appDatabase');
