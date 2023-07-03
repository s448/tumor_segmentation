import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:image_picker/image_picker.dart';
import 'package:tumer_segmentation/view/result_page.dart';
import 'package:tumer_segmentation/model/response.dart';

import '../components/dialog.dart';

class ApiServices extends GetxController {
  final ImagePicker? imagePicker = ImagePicker();
  File? imgFile;

  selectImgFromGallery(bool camFlag) async {
    XFile? file = await imagePicker?.pickImage(
        source: camFlag ? ImageSource.camera : ImageSource.gallery);
    if (file != null) {
      imgFile = File(file.path);
    }
    update();
  }
  removeImg() {
    imgFile = null;
    uploading = false;
    update();
  }
  bool uploading = false;
  uploadImgToServer() async {
    String fileName = imgFile!
        .path
        .split('/')
        .last;
    var dio = Dio();
    var response;
    dio.options.connectTimeout = 8000;
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imgFile!.path, filename: fileName),
      // "key": "7366d145db31b71b6b2c5f674cc82dd4",
      // "image": await MultipartFile.fromFile(imgFile!.path, filename: fileName),
      // "name": fileName,
    });
    try {
      response = await dio.post(
        //"https://6f92-196-129-138-12.eu.ngrok.io/predict", //hosting on ngrok
        "http://10.0.2.2:8080/predict", //hosting on local machine
        // "https://api.imgbb.com/1/upload", //testing the app on test API
        data: formData,
        onSendProgress: ((count, total) {
          uploading = true;
          print("$count / $total");
          update();
        }),
        onReceiveProgress: (count, total) {
          print("Receiving.....");
        },
      );
    } catch (e) {
      if (e is DioError && e.type == DioErrorType.connectTimeout) {
        // Handle timeout error
        failureDialog(
            'Request failed', 'Timeout please check your internet connection');
        print('Timeout error: $e');
        // Display a message to the user
      } else {
        // Handle other Dio errors
        print('Other Dio error: $e');
        // Display a message to the user
      }
    }
    if (response != null) {
      final Map<String, dynamic> parsed = json.decode(response.toString());
      final ResponseModel res = ResponseModel.fromJson(parsed);
      if (res.result != -1) {
        Get.to(const ResultPage(), arguments: res);
      }
      else {
        Get.snackbar("Couldn't diagnose the image", "please try again");
      }
    }
    uploading = false;
    update();
  }
}