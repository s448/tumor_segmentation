import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumer_segmentation/components/app_bar.dart';
import 'package:tumer_segmentation/model/response.dart' hide Image;
import 'package:url_launcher/url_launcher.dart';

import '../controller/upload_mri_controller.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  UploadMRIController logic = Get.find();
  ResponseModel? data;
  var url;
  @override
  void initState() {
    data = Get.arguments;
    debugPrint(data!.toJson().toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool result = data!.result == 0;
    String message = result ? "Tumor doesn't exist" : "Tumor Exists";
    return Scaffold(
      appBar: AppBar(
        title: const SharedAppBar(),
        toolbarHeight: Get.height * 0.2,
        actions: null,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.file(
                logic.imgFile!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(12.0),
            width: Get.width,
            height: Get.height * 0.15,
            child: Column(
              children: [
                const Text("Result",),
                const SizedBox(height: 5,),
                Text(message, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            )
          )
        ],
      ),
    );
  }
}
