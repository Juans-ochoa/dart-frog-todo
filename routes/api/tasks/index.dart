import 'package:dart_frog/dart_frog.dart';

import '../../../controllers/task_controller.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final request = context.request;

    final method = request.method;

    if (method == HttpMethod.get) {
      return await getAllTasksHandler(context);
    } else if (method == HttpMethod.post) {
      return createTaskHandler(context);
    }

    return Response.json(
      statusCode: 408,
      body: {'message': 'Method not allowed'},
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {
        'message': 'Server error. Something went wrong',
        'error': e.toString(),
      },
    );
  }
}
