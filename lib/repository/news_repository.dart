import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class NewsRepository {
  final Dio _dio = Dio();

  Future addNews(
      {required String title,
      required String content,
      required String date,
      required File image}) async {
    try {
      String fileName = basename(image.path).split('/').last;
      ;
      FormData formData = FormData.fromMap({
        'judul': title,
        'deskripsi': content,
        'tanggal': date,
        'url_image':
            await MultipartFile.fromFile(image.path, filename: fileName),
      });

      Response response = await _dio.post(
        'https://mustikara.000webhostapp.com/addnews.php/',
        data: formData,
      );

      log(response.data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to add news');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future getNewsList(keyword) async {
    try {
      log("GETTING NEWS");
      var response = await _dio.get(
        'https://mustikara.000webhostapp.com/listnews.php/',
        queryParameters: {'key': keyword},
      );
      log("list $response");

      if (response.statusCode == 200) {
        log("MASUK KONDISI IF LIST 200");
        List newsList = response.data;
        return newsList;
      } else {
        // Handle error cases if needed
        log('Error: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      // Handle Dio errors or network issues
      log('Dio Error: $error');
      return [];
    }
  }

  Future selectNews(String id) async {
    FormData formData = FormData.fromMap({
      'idnews': id,
    });
    // try {
    final response = await _dio.post(
      'https://mustikara.000webhostapp.com/selectdata.php/',
      data: formData,
    );
    Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);
    // ${response.data['status]}
    log("Res $responseData");
    if (responseData['success'] == true) {
      responseData['data']['status'] = true;
      return responseData['data'];
    } else {
      return {'status': false, 'msg': responseData['msg']};
    }
  }

  Future editNews(
      {required String id,
      required String title,
      required String content,
      required String date,
      File? image}) async {
    try {
      String fileName = basename(image!.path).split('/').last;
      ;
      Map<String, dynamic> formDataMap = {
        'idnews': id,
        'judul': title,
        'deskripsi': content,
        'tanggal': date,
      };
      if (image != null) {
        formDataMap['url_image'] =
            await MultipartFile.fromFile(image.path, filename: fileName);
      }
      FormData formData = FormData.fromMap(formDataMap);

      Response response = await _dio.post(
        'https://mustikara.000webhostapp.com/editnews.php/',
        data: formData,
      );

      log("RES ${response.data}");
      // return response.data['status'];
      if (response.statusCode == 200 && response.data['status'] == true) {
        return true;
      } else {
        return false;
        // throw Exception('Failed to edit news');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future deleteNews(String id) async {
    try {
      FormData formData = FormData.fromMap({
        'idnews': id,
      });
      final response = await _dio.post(
        'https://mustikara.000webhostapp.com/deletenews.php/',
        data: formData,
      );
      Map responseData = response.data;
      if (responseData['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
