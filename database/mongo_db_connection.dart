import 'package:mongo_dart/mongo_dart.dart';

import '../config/config.dart';

class MongoDbConnection {
  bool _initialized = false;
  late Db _database;
  late DbCollection _tasksCollections;

  bool get isInitialized => _initialized;

  Db get database => _database;

  DbCollection get tasksCollection => _tasksCollections;

  Future<void> initializeDatabase() async {
    if (!_initialized) {
      _database = await Db.create(Config.mongoDBUrl);
      _initialized = true;
      _tasksCollections = _database.collection('tasks');
    }
  }

  Future<void> open() async {
    try {
      await _database.open();
    } catch (e) {
      throw Exception('Error to connect database');
    }
  }

  Future<void> close() async {
    if (_database.isConnected) {
      await _database.close();
    }
  }
}
