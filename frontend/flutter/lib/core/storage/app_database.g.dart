// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppKeyValuesTable extends AppKeyValues
    with TableInfo<$AppKeyValuesTable, AppKeyValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppKeyValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_key_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppKeyValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppKeyValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppKeyValue(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppKeyValuesTable createAlias(String alias) {
    return $AppKeyValuesTable(attachedDatabase, alias);
  }
}

class AppKeyValue extends DataClass implements Insertable<AppKeyValue> {
  final String key;
  final String value;
  const AppKeyValue({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppKeyValuesCompanion toCompanion(bool nullToAbsent) {
    return AppKeyValuesCompanion(key: Value(key), value: Value(value));
  }

  factory AppKeyValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppKeyValue(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppKeyValue copyWith({String? key, String? value}) =>
      AppKeyValue(key: key ?? this.key, value: value ?? this.value);
  AppKeyValue copyWithCompanion(AppKeyValuesCompanion data) {
    return AppKeyValue(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppKeyValue(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppKeyValue &&
          other.key == this.key &&
          other.value == this.value);
}

class AppKeyValuesCompanion extends UpdateCompanion<AppKeyValue> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppKeyValuesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppKeyValuesCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppKeyValue> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppKeyValuesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppKeyValuesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppKeyValuesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppKeyValuesTable appKeyValues = $AppKeyValuesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [appKeyValues];
}

typedef $$AppKeyValuesTableCreateCompanionBuilder =
    AppKeyValuesCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppKeyValuesTableUpdateCompanionBuilder =
    AppKeyValuesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppKeyValuesTableFilterComposer
    extends Composer<_$AppDatabase, $AppKeyValuesTable> {
  $$AppKeyValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppKeyValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppKeyValuesTable> {
  $$AppKeyValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppKeyValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppKeyValuesTable> {
  $$AppKeyValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppKeyValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppKeyValuesTable,
          AppKeyValue,
          $$AppKeyValuesTableFilterComposer,
          $$AppKeyValuesTableOrderingComposer,
          $$AppKeyValuesTableAnnotationComposer,
          $$AppKeyValuesTableCreateCompanionBuilder,
          $$AppKeyValuesTableUpdateCompanionBuilder,
          (
            AppKeyValue,
            BaseReferences<_$AppDatabase, $AppKeyValuesTable, AppKeyValue>,
          ),
          AppKeyValue,
          PrefetchHooks Function()
        > {
  $$AppKeyValuesTableTableManager(_$AppDatabase db, $AppKeyValuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppKeyValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppKeyValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppKeyValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppKeyValuesCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppKeyValuesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppKeyValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppKeyValuesTable,
      AppKeyValue,
      $$AppKeyValuesTableFilterComposer,
      $$AppKeyValuesTableOrderingComposer,
      $$AppKeyValuesTableAnnotationComposer,
      $$AppKeyValuesTableCreateCompanionBuilder,
      $$AppKeyValuesTableUpdateCompanionBuilder,
      (
        AppKeyValue,
        BaseReferences<_$AppDatabase, $AppKeyValuesTable, AppKeyValue>,
      ),
      AppKeyValue,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppKeyValuesTableTableManager get appKeyValues =>
      $$AppKeyValuesTableTableManager(_db, _db.appKeyValues);
}
