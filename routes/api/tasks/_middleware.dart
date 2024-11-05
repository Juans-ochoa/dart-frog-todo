import 'package:dart_frog/dart_frog.dart';

import '../../../database/mongo_db_connection.dart';
import '../../../repositories/task_repository_impl.dart';
import '../../../usecases/create_task_use_case.dart';
import '../../../usecases/delete_task_use_case.dart';
import '../../../usecases/get_task_by_id_use_case.dart';
import '../../../usecases/get_tasks_use_case.dart';
import '../../../usecases/update_task_use_case.dart';

Handler middleware(Handler handler) {
  return handler
      .use(createTaskMiddleware())
      .use(updateTaskMiddleware())
      .use(deleteTaskMiddleware())
      .use(getTaskByIdMiddleware())
      .use(getAllTasksMiddleware());
}

Middleware getTaskByIdMiddleware() {
  return (Handler handler) {
    return (context) async {
      final mongoService = context.read<MongoDbConnection>();
      final collection = mongoService.tasksCollection;

      final repository = TaskRepositoryImpl(collection);

      final updatedContext = context.provide<GetTaskByIdUseCase>(
        () => GetTaskByIdUseCase(repository),
      );

      return await handler(updatedContext);
    };
  };
}

Middleware getAllTasksMiddleware() {
  return (Handler handler) {
    return (RequestContext context) async {
      final mongoService = context.read<MongoDbConnection>();
      final collection = mongoService.tasksCollection;

      final repository = TaskRepositoryImpl(collection);
      final updatedContext = context.provide<GetTasksUseCase>(
        () => GetTasksUseCase(repository),
      );

      return await handler(updatedContext);
    };
  };
}

Middleware createTaskMiddleware() {
  return (Handler handler) {
    return (RequestContext context) async {
      final mongoService = context.read<MongoDbConnection>();
      final collection = mongoService.tasksCollection;

      final repository = TaskRepositoryImpl(collection);

      final updatedContext = context.provide<CreateTaskUseCase>(
        () => CreateTaskUseCase(repository),
      );
      return await handler(updatedContext);
    };
  };
}

Middleware deleteTaskMiddleware() {
  return (Handler handler) {
    return (RequestContext context) async {
      final mongoService = context.read<MongoDbConnection>();
      final collection = mongoService.tasksCollection;

      final repository = TaskRepositoryImpl(collection);

      final updatedContext = context
          .provide<DeleteTaskUseCase>(() => DeleteTaskUseCase(repository));
      return await handler(updatedContext);
    };
  };
}

Middleware updateTaskMiddleware() {
  return (Handler handler) {
    return (RequestContext context) async {
      final mongoService = context.read<MongoDbConnection>();
      final collection = mongoService.tasksCollection;

      final repository = TaskRepositoryImpl(collection);

      final updateContext = context.provide<UpdateTaskUseCase>(
        () => UpdateTaskUseCase(repository),
      );

      return handler(updateContext);
    };
  };
}
