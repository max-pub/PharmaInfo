import 'dart:io';
import 'lib/io.dart';
import 'lib/pharmacon.dart';

void main(List<String> arguments) async {
  try {
    int port = int.parse(arguments[0]);
    startServer(InternetAddress.loopbackIPv4, port);
  } catch (error) {
    Pharmacon pharmacon =
        await loadPharmacon(language: arguments[0], query: arguments[1]);
    print(pharmacon.JSON);
  }
}

/// start a server on port [port]
void startServer(InternetAddress host, int port) {
  HttpServer.bind(host, port).then((_server) {
    print("LISTENING ON ${host.address}:$port");
    _server.listen((HttpRequest request) {
      // print(request);
      handleGetRequest(request);
    }, onError: handleError);
  }).catchError(handleError);
}

void handleGetRequest(HttpRequest request) async {
  // print(request);
  HttpResponse response = request.response;
  List<String> path = request.uri.path
      .split('/')
      .where((element) => element.length > 0)
      .toList();
  print("PATH:" + request.uri.path);
  if (path.length == 0) {
    response.headers.set("Content-Type", "text/html; charset=utf-8");
    response.write(File('web.htm').readAsStringSync());
  }
  if (path.length == 2) {
    response.headers.set("Content-Type", "application/json; charset=utf-8");

    // print(path);
    // response.write('Received request ${request.method}: ${request.uri.path}');
    // response.write('{"a":1}');
    // response.write(respondJSON());
    Pharmacon pharmacon = await loadPharmacon(language: path[0], query: path[1]);
    print("out now");
    print(pharmacon.JSON);
    response.write(pharmacon.JSON);
  }
  response.close();
}

dynamic handleError(Object a) {
  print("FAIL");
}
