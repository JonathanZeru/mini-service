import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:mini_service_booking/utils/config.dart';
import 'package:mini_service_booking/utils/storages.dart';
import 'package:mini_service_booking/utils/utils.dart';
import 'package:http/http.dart';
import 'package:mime/mime.dart';

enum RContentTypes {
  json("application/json"),
  urlEncoded("application/x-www-form-urlencoded"),
  formData("multipart/form-data"),
  text("text/plain");

  final String mimeType;

  const RContentTypes(this.mimeType);

  @override
  String toString() => mimeType;
}

enum HttpMethods {
  get('GET'),
  post('POST'),
  patch('PATCH'),
  put('PUT'),
  delete('DELETE'),
  head('HEAD');

  final String method;
  const HttpMethods(this.method);

  @override
  String toString() => method;
}

class NetworkHandler {
  String baseUrl;
  static Map<String, String> headers = {
    "ContentType": RContentTypes.json.mimeType,
  };
  static TokenPair? _tokenPair;
  static set tokenPair(TokenPair pair) {
    _tokenPair = pair;
  }

  static Future<void> loadTokenPair() async {
    final authStorage = HiveAuthStorage();
    _tokenPair = await authStorage.readTokens();
  }

  RContentTypes contentType;

  NetworkHandler({
    this.baseUrl = appServerBaseUrl,
    this.contentType = RContentTypes.json,
  });

  String encodeBody(Map<String, dynamic> body) {
    return body.entries
        .map((entry) {
          return '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value.toString())}';
        })
        .join('&');
  }

  Future<Response> post({
    String? path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
  }) {
    logger.e(body);
    return makeRequest(
      path: path,
      body: body,
      method: HttpMethods.post,
      headers: headers,
      onProgress: onProgress,
      includeAccessToken: includeAccessToken,
    );
  }

  Future<Response> postLogin({
    String? path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
    RContentTypes contentType = RContentTypes.json, // Add contentType parameter
  }) async {
    logger.e(body);

    // Encode the body based on the content type
    final encodedBody =
        contentType == RContentTypes.urlEncoded
            ? encodeBody(body)
            : jsonEncode(body);

    // Set the Content-Type header
    headers ??= {};
    headers["Content-Type"] = contentType.mimeType;

    // Make the request
    final response = await makeLoginRequest(
      path: path,
      body: encodedBody,
      method: HttpMethods.post,
      headers: headers,
      onProgress: onProgress,
      includeAccessToken: includeAccessToken,
    );

    return response;
  }

  Future<Response> postSignUp({
    String? path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
    RContentTypes contentType = RContentTypes.json, // Add contentType parameter
    HttpMethods requestMethod = HttpMethods.post,
  }) async {
    // Encode the body based on the content type
    final encodedBody =
        contentType == RContentTypes.urlEncoded
            ? encodeBody(body)
            : jsonEncode(body);

    // Set the Content-Type header
    headers ??= {};
    headers["Content-Type"] = contentType.mimeType;

    // Make the request
    final response = await makeSignUpRequest(
      path: path,
      body: encodedBody,
      method: HttpMethods.post,
      headers: headers,
      onProgress: onProgress,
      includeAccessToken: includeAccessToken,
    );

    return response;
  }

  Future<Response> patch({
    String? path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
  }) {
    return makeRequest(
      path: path,
      body: body,
      method: HttpMethods.patch,
      headers: headers,
      onProgress: onProgress,
      includeAccessToken: includeAccessToken,
    );
  }

  Future<Response> put({
    String? path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
  }) {
    return makeRequest(
      path: path,
      body: body,
      method: HttpMethods.put,
      headers: headers,
      onProgress: onProgress,
      includeAccessToken: includeAccessToken,
    );
  }

  Future<Response> makeLoginRequest({
    String? path,
    required dynamic body, // Change to dynamic to handle both String and Map
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
    HttpMethods method = HttpMethods.post,
  }) async {
    final uri = Uri.parse('$baseUrl${path ?? ''}');
    // Load token if it's not already set
    if (_tokenPair == null) {
      await loadTokenPair();
    }
    headers ??= {};

    if (includeAccessToken) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer ${_tokenPair?.access}';
    }

    // Send the request
    final response = await client.post(
      uri,
      headers: headers,
      body: body, // Use the encoded body
    );

    return response;
  }

  Future<Response> makeSignUpRequest({
    String? path,
    required dynamic body, // Change to dynamic to handle both String and Map
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
    HttpMethods method = HttpMethods.post,
  }) async {
    final uri = Uri.parse('https://api.dev.gibe.market/v1${path ?? ''}');
    // Load token if it's not already set
    if (_tokenPair == null) {
      await loadTokenPair();
    }
    headers ??= {};

    if (includeAccessToken) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer ${_tokenPair?.access}';
    }

    // Send the request
    final response = await client.post(
      uri,
      headers: headers,
      body: body, // Use the encoded body
    );

    return response;
  }

  Future<Response> makeRequest({
    String? path,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
    HttpMethods method = HttpMethods.post,
  }) async {
    final uri = Uri.parse('$baseUrl${path ?? ''}');
    final boundary = '----dart${DateTime.now().microsecondsSinceEpoch}';

    final bodyBytes = _prepareBody(
      type: contentType,
      body: body,
      boundary: boundary,
    );
    // Load token if it's not already set
    if (_tokenPair == null) {
      await loadTokenPair();
    }
    headers ??= {};

    if (includeAccessToken) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer ${_tokenPair?.access}';
    }
    headers = {
      'Content-Type': '${contentType.toString()};boundary=$boundary',
      ...headers,
    };
    return _makeRequest(
      bytes: bodyBytes,
      uri: uri,
      method: method,
      headers: headers,
      onProgress: onProgress,
    );
  }

  static Uint8List _prepareBody({
    required RContentTypes type,
    required Map<String, dynamic> body,
    String? boundary,
  }) {
    switch (type) {
      case RContentTypes.json:
        logger.e("1 type: $type");
        return _convertToJsonBinary(body);
      case RContentTypes.urlEncoded:
        logger.e("2 type: $type");
        return _convertToUrlEncodedBinary(body);
      case RContentTypes.formData:
        logger.e("3 type: $type");
        return _convertToMultipartBinary(body, boundary!);
      case RContentTypes.text:
        logger.e("4 type: $type");
        throw UnimplementedError();
    }
  }

  static Uint8List _convertToUrlEncodedBinary(Map<String, dynamic> json) =>
      utf8.encode(Uri(queryParameters: json).query);

  static Uint8List _convertToJsonBinary(Map<String, dynamic> json) =>
      utf8.encode(jsonEncode(json));

  static Uint8List _convertToMultipartBinary(
    Map<String, dynamic> jsonData,
    String boundary,
  ) {
    var encoded = <int>[];

    for (var entry in jsonData.entries) {
      var key = entry.key;
      var value = entry.value;

      if (value is List<File>) {
        for (var file in value) {
          var fileName = file.path.split('/').last;
          var fileBytes = file.readAsBytesSync();
          encoded.addAll(utf8.encode('--$boundary\r\n'));
          encoded.addAll(
            utf8.encode(
              'Content-Disposition: form-data; name="$key"; filename="$fileName"\r\n',
            ),
          );
          encoded.addAll(
            utf8.encode(
              'Content-Type: ${_getFileContentType(file.path)}\r\n\r\n',
            ),
          );
          encoded.addAll(fileBytes);
          encoded.addAll(utf8.encode('\r\n'));
        }
      } else {
        encoded.addAll(utf8.encode('--$boundary\r\n'));

        if (value is File) {
          var fileName = value.path.split('/').last;
          logger.e('Reading File');
          var fileBytes = value.readAsBytesSync();
          logger.e('Reading File Done');

          encoded.addAll(
            utf8.encode(
              'Content-Disposition: form-data; name="$key"; filename="$fileName"\r\n',
            ),
          );
          encoded.addAll(
            utf8.encode(
              'Content-Type: ${_getFileContentType(value.path)}\r\n\r\n',
            ),
          );
          encoded.addAll(fileBytes);
        } else {
          encoded.addAll(
            utf8.encode('Content-Disposition: form-data; name="$key"\r\n\r\n'),
          );
          encoded.addAll(utf8.encode(value.toString()));
        }
        encoded.addAll(utf8.encode('\r\n'));
      }
    }

    encoded.addAll(utf8.encode('--$boundary--\r\n'));
    return Uint8List.fromList(encoded);
  }

  static Future<Response> _makeRequest({
    required List<int> bytes,
    required Uri uri,
    required HttpMethods method,
    required Map<String, String> headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
  }) async {
    var byteStream = _streamByteChunck(bytes);

    final request = await httpClient.openUrl(method.toString(), uri);

    request.headers.set("Content-Length", bytes.length.toString());

    for (var header in headers.entries) {
      request.headers.set(header.key, header.value);
    }
    request.contentLength = bytes.length;
    int byteCount = 0;

    Stream<List<int>> streamUpload = byteStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          byteCount += data.length;

          if (onProgress != null) {
            onProgress(byteCount, bytes.length);
          }

          sink.add(data);
        },
        handleError: (error, stack, sink) {
          if (kDebugMode) {
            print(error.toString());
          }
        },
        handleDone: (sink) {
          sink.close();
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();
    final receivedBytes = await httpResponse.fold(<int>[], (prev, current) {
      prev += current;

      return prev;
    });

    return Response.bytes(receivedBytes, httpResponse.statusCode);
  }

  Future<Response> get({
    String? path,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    void Function(int byteCount, int totalByteLength)? onProgress,
    bool includeAccessToken = false,
  }) async {
    path ??= '';

    // Add query parameters to the path
    if (queryParams != null) {
      path += "?";
      for (final query in queryParams.entries) {
        path = '$path${query.key}=${query.value}&';
      }
    }

    // Set the base URL
    baseUrl = "https://api.dev.gibe.market/v1";

    // Create the URI
    final uri = Uri.parse(baseUrl + path!);

    if (_tokenPair == null) {
      await loadTokenPair();
    }
    // Log the full URL for debugging
    logger.e("GET Request URL: ${uri.toString()}");
    logger.e("Bearer ${_tokenPair?.access.token}");
    // Load token if it's not already set
    if (includeAccessToken) {
      headers?[HttpHeaders.authorizationHeader] =
          'Bearer ${_tokenPair?.access.token}';
    }

    // Make the GET request
    final response = await client.get(uri, headers: headers);

    // Log the response for debugging
    logger.e("GET Response Status Code: ${response.statusCode}");
    logger.e("GET Response Body: ${response.body}");

    return response;
  }

  Future<Response> delete({
    String? path,
    Map<String, String>? headers,
    bool includeAccessToken = false,
  }) async {
    headers ??= {};
    // Load token if it's not already set
    if (_tokenPair == null) {
      await loadTokenPair();
    }
    return await client.delete(
      Uri.parse('$baseUrl${path ?? ''}'),
      headers: {
        ...NetworkHandler.headers,
        ...headers,
        if (includeAccessToken)
          HttpHeaders.authorizationHeader:
              "Bearer ${_tokenPair?.access.token ?? ""}",
      },
    );
  }

  static Client get client => Client();
  static HttpClient get httpClient => HttpClient();

  static String _getFileContentType(String filePath) {
    final mimeType = lookupMimeType(filePath);
    return mimeType ?? "application/octet-stream";
  }

  static Stream<List<int>> _streamByteChunck(List<int> bytes) async* {
    for (int i = 0; i < bytes.length; i += 1024) {
      yield bytes.sublist(i, min(bytes.length, i + 1024));
    }
  }
}
