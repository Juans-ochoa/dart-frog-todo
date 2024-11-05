import 'package:dart_frog/dart_frog.dart';
import 'package:test/test.dart';

Response onRequest(RequestContext context) {
  final method = context.request.method;

  switch (method) {
    case HttpMethod.get:
      return Response(body: 'Welcome to Dart Frog! Method: $method');
    case HttpMethod.post:
      return Response(body: 'Welcome to Dart Frog! Method: $method');
    case HttpMethod.put:
      return Response(body: 'Welcome to Dart Frog! Method: $method');
    case HttpMethod.delete:
      return Response(body: 'Welcome to Dart Frog! Method: $method');
    case HttpMethod.patch:
      return Response(body: 'Welcome to Dart Frog! Method: $method');
    case HttpMethod.options:
      return Response(body: 'Welcome to Dart Frog! Method: $method');
    default:
      throw throwsNoSuchMethodError;
  }
}
