import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio = Dio();
  Future<List> getProducts({
    required String path,
  }) async {
    Response response = await dio.get(path);
    return response.data["products"];
  }
}
