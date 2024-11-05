import 'package:dart_frog/dart_frog.dart';

import '../middleware/mongo_db_middleware.dart';

Handler middleware(Handler handler) {
  return handler.use(mongoDbMiddleware());
}
