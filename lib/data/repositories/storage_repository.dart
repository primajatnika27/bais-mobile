import 'package:bais_mobile/data/providers/storage_provider.dart';
import 'package:bais_mobile/services/http_service.dart';
import 'package:dio/dio.dart';

class StorageRepository {
  late final StorageProvider _provider;

  StorageRepository() {
    final httpService = HttpService(baseUrl: '');
    _provider = StorageProvider(httpService);
  }

  Future<String> uploadFile(String path) => _provider.uploadFile(path);

  Future<Response> downloadFile(String fileName) async {
    return await _provider.downloadFile(fileName);
  }
}