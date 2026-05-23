import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oncare/core/storage/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('putValue → readValue roundtrip', () async {
    await db.putValue('locale', 'ko');
    expect(await db.readValue('locale'), 'ko');
  });

  test('deleteValue removes the entry', () async {
    await db.putValue('locale', 'ko');
    await db.deleteValue('locale');
    expect(await db.readValue('locale'), isNull);
  });

  test('putValue upserts on conflicting key', () async {
    await db.putValue('k', 'v1');
    await db.putValue('k', 'v2');
    expect(await db.readValue('k'), 'v2');
  });
}
