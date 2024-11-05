import 'package:dart_frog/dart_frog.dart';

import '../usecases/create_task_use_case.dart';
import '../usecases/delete_task_use_case.dart';
import '../usecases/get_task_by_id_use_case.dart';
import '../usecases/get_tasks_use_case.dart';
import '../usecases/update_task_use_case.dart';

Future<Response> getTaskByIdHandler(RequestContext context, String id) async {
  final useCase = context.read<GetTaskByIdUseCase>();
  final task = await useCase(id);

  return Response.json(body: task.toMap());
}

Future<Response> getAllTasksHandler(RequestContext context) async {
  final useCase = context.read<GetTasksUseCase>();

  final tasksList = await useCase();
  final tasks = tasksList.map((task) => task.toMap()).toList();
  return Response.json(body: tasks);
}

Future<Response> createTaskHandler(RequestContext context) async {
  final data = await context.request.json() as Map<String, dynamic>;
  final useCase = context.read<CreateTaskUseCase>();

  final task = await useCase(
    data['title'] as String,
    data['description'] as String,
    data['urlImage'] as String,
  );

  return Response.json(body: {'data': task.toMap(), 'message': 'Task created'});
}

Future<Response> updateTaskHandler(RequestContext context, String id) async {
  final data = await context.request.json() as Map<String, dynamic>;
  final useCase = context.read<UpdateTaskUseCase>();

  final task = await useCase(
    id,
    data['title'] as String,
    data['description'] as String,
    data['urlImage'] as String,
  );

  return Response.json(
    body: {
      'message': 'Task with id: $id was updated!',
      'task': task.toMap(),
    },
  );
}

Future<Response> deleteTaskHandler(RequestContext context, String id) async {
  final useCase = context.read<DeleteTaskUseCase>();
  final message = await useCase(id);

  return Response.json(body: message);
}
