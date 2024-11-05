import 'package:dart_frog/dart_frog.dart';

import '../../../controllers/task_controller.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final request = context.request;

  final method = request.method;

  try {
    if (method == HttpMethod.get) {
      return getTaskByIdHandler(context, id);
    } else if (method == HttpMethod.put) {
      return updateTaskHandler(context, id);
    } else if (method == HttpMethod.delete) {
      return deleteTaskHandler(context, id);
    } else {
      return Response.json(
        statusCode: 408,
        body: {'message': 'Method not allowed'},
      );
    }
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {
        'message': 'Server error. Something went wrong',
        'error': e.toString(),
      },
    );
  }
  return Response(body: 'This is a new route!');
}
