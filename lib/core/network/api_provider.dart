import 'dart:convert';
import 'package:get/get.dart';
import 'package:service_booking_app/core/errors/exceptions.dart';

class ApiProvider extends GetConnect {
  final String baseUrl;

  ApiProvider({required this.baseUrl}) {
    httpClient.baseUrl = baseUrl;
    httpClient.timeout = const Duration(seconds: 15);
  }

  Future<dynamic> fetch(String endpoint) async {
    try {
      final response = await httpClient.get(endpoint);
      return _processResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Response<T>> post<T>(
    String? endpoint,
    dynamic body, {
    String? contentType,
    T Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    dynamic Function(double)? uploadProgress,
  }) async {
    try {
      print(endpoint);
      final response = await httpClient.post<T>(
        endpoint,
        body: body,
        contentType: contentType,
        decoder: decoder,
        headers: headers,
        query: query,
        uploadProgress: uploadProgress,
      );
      return response;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Response<T>> put<T>(
    String endpoint,
    dynamic body, {
    String? contentType,
    T Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    dynamic Function(double)? uploadProgress,
  }) async {
    try {
      final response = await httpClient.put<T>(
        endpoint,
        body: body,
        contentType: contentType,
        decoder: decoder,
        headers: headers,
        query: query,
        uploadProgress: uploadProgress,
      );
      return response;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Response<T>> delete<T>(
    String endpoint, {
    String? contentType,
    T Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await httpClient.delete<T>(
        endpoint,
        contentType: contentType,
        decoder: decoder,
        headers: headers,
        query: query,
      );
      return response;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  dynamic _processResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body;
      case 400:
        throw BadRequestException(
          message:
              response.body != null
                  ? json.encode(response.body)
                  : 'Bad request',
        );
      case 401:
      case 403:
        throw UnauthorizedException(
          message:
              response.body != null
                  ? json.encode(response.body)
                  : 'Unauthorized',
        );
      case 404:
        throw NotFoundException(
          message:
              response.body != null
                  ? json.encode(response.body)
                  : 'Resource not found',
        );
      case 500:
      default:
        throw ServerException(
          message:
              response.body != null
                  ? json.encode(response.body)
                  : 'Server error',
        );
    }
  }
}
