import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_client/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:tumer_segmentation/view/home_page.dart';
import 'package:tumer_segmentation/view/result_page.dart';
import 'package:tumer_segmentation/model/response.dart';
class UploadMRIController extends GetxController {
  final ImagePicker? imagePicker = ImagePicker();
  File? imgFile;

  selectImgFromGallery() async {
    XFile? file = await imagePicker?.pickImage(source: ImageSource.gallery);
    if (file != null) {
      imgFile = File(file.path);
    }
    update();
  }

  bool uploading = false;

  uploadImgToServer() async {
    String fileName = imgFile!.path.split('/').last;
    var dio = Dio();
    var formData = FormData.fromMap({
      "key": "7366d145db31b71b6b2c5f674cc82dd4",
      "image": await MultipartFile.fromFile(imgFile!.path, filename: fileName),
      "name": fileName,
    });
    var response = await dio.post(
      "https://api.imgbb.com/1/upload",
      data: formData,
      onSendProgress: ((count, total){
        uploading = true;
        getUploadStates(count, total);
        print("$count / $total");
        update();
      }),
        onReceiveProgress: (count, total) {
          print("Receiving.....");
        },
    );
    if(response != null) {
      final Map<String,dynamic> parsed = json.decode(response.toString());
      final ResponseModel res = ResponseModel.fromJson(parsed);

      // print(res.data!.image!.url.toString());
     //print(">>>>>>>>>>>>>>>>>>>>>>>>>"+ list.data.toString());
      Get.to(ResultPage(),arguments: res);
    }
    uploading = false;
    update();
    // debugPrint(response.toString());
  }
  var count = 0;
  var total = 0;
  getUploadStates(int count,int total){
    this.count=count;
    this.total=total;
    update();
  }
}
