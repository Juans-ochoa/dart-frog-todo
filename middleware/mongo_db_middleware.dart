import 'dart:async';

import 'package:dart_frog/dart_frog.dart';

import '../database/mongo_db_connection.dart';

final MongoDbConnection mongoDbService = MongoDbConnection();

Future<void> initializeMongoDbConnection() async {
  if (!mongoDbService.isInitialized) {
    await mongoDbService.initializeDatabase();
    await mongoDbService.open();
  }
}

Middleware mongoDbMiddleware() {
  return (Handler handler) {
    return (context) async {
      try {
        await initializeMongoDbConnection();

        final updateContext =
            context.provide<MongoDbConnection>(() => mongoDbService);

        return await handler(updateContext);
      } catch (e) {
        return Response.json(
          statusCode: 500,
          body: {
            'error': 'Something was wrong',
            'details': e.toString(),
          },
        );
      }
    };
  };
}
