import 'dart:io';
import 'package:service_booking_app/core/errors/exceptions.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ApiProvider apiProvider;
  final String endpoint;
  final String baseUrl;

  ServicesRepositoryImpl({
    required this.apiProvider,
    required this.endpoint,
    required this.baseUrl,
  });

  @override
  Future<Either<Failure, List<ServiceModel>>> getServices({
    String? categoryId,
    double? price,
    bool? availability,
    int? duration,
    double? rating,
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, String>{};
      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (price != null) queryParams['price'] = price.toString();
      if (availability != null) queryParams['availability'] = availability.toString();
      if (duration != null) queryParams['duration'] = duration.toString();
      if (rating != null) queryParams['rating'] = rating.toString();

      // Construct query string
      String queryString = '';
      if (queryParams.isNotEmpty) {
        queryString = '?';
        queryParams.forEach((key, value) {
          queryString += '$key=$value&';
        });
        queryString = queryString.substring(0, queryString.length - 1); // Remove trailing &
      }

      final response = await apiProvider.get('$endpoint$queryString');
      final List<dynamic> servicesJson = response.body as List;
      final List<ServiceModel> services = servicesJson
          .map((serviceJson) => ServiceModel.fromJson(serviceJson.body as Map<String, dynamic>))
          .toList();
      return Right(services);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> getService(String id) async {
    try {
      final response = await apiProvider.get('$endpoint/$id');
      final ServiceModel service = ServiceModel.fromJson(response.body as Map<String, dynamic>);
      return Right(service);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> createService(
      ServiceModel service, File? imageFile) async {
    try {
      if (imageFile != null) {
        // Upload image and get URL
        final imageUrl = await _uploadImage(imageFile);
        // Create service with the image URL
        final updatedService = service.copyWith(imageUrl: imageUrl);
        final response = await apiProvider.post(endpoint, updatedService.toJson());
        final ServiceModel createdService = ServiceModel.fromJson(response.body as Map<String, dynamic>);
        return Right(createdService);
      } else {
        // Create service with the provided image URL
        final response = await apiProvider.post(endpoint, service.toJson());
        final ServiceModel createdService = ServiceModel.fromJson(response.body as Map<String, dynamic>);
        return Right(createdService);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> updateService(
      String id, ServiceModel service, File? imageFile) async {
    try {
      if (imageFile != null) {
        // Upload image and get URL
        final imageUrl = await _uploadImage(imageFile);
        // Update service with the new image URL
        final updatedService = service.copyWith(imageUrl: imageUrl);
        final response = await apiProvider.put('$endpoint/$id', updatedService.toJson());
        final ServiceModel updatedServiceResponse = ServiceModel.fromJson(response.body as Map<String, dynamic>);
        return Right(updatedServiceResponse);
      } else {
        // Update service with the existing image URL
        final response = await apiProvider.put('$endpoint/$id', service.toJson());
        final ServiceModel updatedService = ServiceModel.fromJson(response.body as Map<String, dynamic>);
        return Right(updatedService);
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteService(String id) async {
    try {
      await apiProvider.delete('$endpoint/$id');
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // Helper method to upload image to a hosting service
  // In a real app, you would upload to your own server or a service like Firebase Storage
  Future<String> _uploadImage(File imageFile) async {
    try {
      // For demo purposes, we'll use a multipart request to upload to ImgBB or similar service
      // In a real app, you would use your own server or a service like Firebase Storage
      
      // This is a placeholder. In a real app, you would implement actual image upload
      // For now, we'll return a placeholder URL
      await Future.delayed(const Duration(seconds: 2)); // Simulate upload time
      
      // For demonstration purposes, we'll just return a placeholder URL
      // In a real app, you would get the URL from the upload response
      return 'https://via.placeholder.com/300';
      
      // Example of how you might implement actual image upload:
      /*
      var request = http.MultipartRequest('POST', Uri.parse('https://api.imgbb.com/1/upload'));
      request.fields['key'] = 'YOUR_API_KEY';
      
      var multipartFile = await http.MultipartFile.fromPath(
        'image', 
        imageFile.path,
        contentType: MediaType('image', extension(imageFile.path).substring(1)),
      );
      
      request.files.add(multipartFile);
      var response = await request.send();
      
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        return jsonResponse['data']['url'];
      } else {
        throw ServerException(message: 'Failed to upload image');
      }
      */
    } catch (e) {
      throw ServerException(message: 'Failed to upload image: ${e.toString()}');
    }
  }
}
