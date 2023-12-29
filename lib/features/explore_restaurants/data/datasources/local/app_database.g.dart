// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RestaurantDao? _restaurantDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `restaurant` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `pictureId` TEXT NOT NULL, `city` TEXT NOT NULL, `rating` REAL NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RestaurantDao get restaurantDAO {
    return _restaurantDAOInstance ??= _$RestaurantDao(database, changeListener);
  }
}

class _$RestaurantDao extends RestaurantDao {
  _$RestaurantDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _restaurantModelInsertionAdapter = InsertionAdapter(
            database,
            'restaurant',
            (RestaurantModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'pictureId': item.pictureId,
                  'city': item.city,
                  'rating': item.rating
                }),
        _restaurantModelDeletionAdapter = DeletionAdapter(
            database,
            'restaurant',
            ['id'],
            (RestaurantModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'pictureId': item.pictureId,
                  'city': item.city,
                  'rating': item.rating
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RestaurantModel> _restaurantModelInsertionAdapter;

  final DeletionAdapter<RestaurantModel> _restaurantModelDeletionAdapter;

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    return _queryAdapter.queryList('SELECT * FROM restaurant',
        mapper: (Map<String, Object?> row) => RestaurantModel(
            id: row['id'] as String,
            name: row['name'] as String,
            description: row['description'] as String,
            pictureId: row['pictureId'] as String,
            city: row['city'] as String,
            rating: row['rating'] as double));
  }

  @override
  Future<void> saveRestaurant(RestaurantModel restaurant) async {
    await _restaurantModelInsertionAdapter.insert(
        restaurant, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSavedRestaurant(RestaurantModel restaurant) async {
    await _restaurantModelDeletionAdapter.delete(restaurant);
  }
}
