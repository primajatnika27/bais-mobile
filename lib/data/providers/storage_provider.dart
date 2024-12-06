import 'package:bais_mobile/core/constants/api_constant.dart';
import 'package:bais_mobile/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageProvider {
  final HttpService _httpService;

  StorageProvider(this._httpService);

  final minio = Minio(
    endPoint: ApiConstant.minioUrl,
    accessKey: ApiConstant.minioAccessKey,
    secretKey: ApiConstant.minioSecretKey,
    useSSL: true,
  );

  Future<String> uploadFile(String path) async {
    const bucket = 'bais-bucket';

    try {
      var fileName = path.split('/').last;
      await minio.fPutObject(bucket, fileName, path);
      return fileName;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<Response> downloadFile(String fileName) async {
    const bucket = 'bais-bucket';

    try {
      if (await Permission.storage.request().isGranted) {
        // Get the directory to save the file
        final downloadPath = await getDownloadsDirectory();
        String filePath = '${downloadPath?.path}/$fileName';

        final url =
        await minio.presignedGetObject(bucket, fileName, expires: 1000);
        var response = await _httpService.download(url, filePath);

        return response;
      }

      return Response(requestOptions: RequestOptions(path: ''));
    } catch (e) {
      print(e);
      return Response(requestOptions: RequestOptions(path: ''));
    }
  }
}
