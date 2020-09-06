import 'dart:io';
import 'lib/wiki_load.dart';
import 'lib/pharmacon.dart';

void main(List<String> arguments) async {
  try {
    int port = int.parse(arguments[0]);
    startServer(InternetAddress.loopbackIPv4, port);
  } catch (error) {
    Pharmacon pharmacon =
        await loadPharmacon(language: arguments[0], name: arguments[1]);
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
  response.headers.set("Content-Type", "application/json");
  List<String> path = request.uri.path
      .split('/')
      .where((element) => element.length > 0)
      .toList();
  // print(path);
  // response.write('Received request ${request.method}: ${request.uri.path}');
  // response.write('{"a":1}');
  // response.write(respondJSON());
  Pharmacon pharmacon = await loadPharmacon(language: path[0], name: path[1]);
  response.write(pharmacon.JSON);
  response.close();
}

dynamic handleError(Object a) {
  print("FAIL");
}
