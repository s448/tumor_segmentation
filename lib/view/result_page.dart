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
    url = Uri.parse(data!.data!.image!.url.toString());
    print(url);
    print(data!.data!.image!.url.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool result = !data!.success!;
    String message = result ? "Congratulations, No Tumor" : "Unfortunately, Tumor Exist";
    return Scaffold(
      appBar: AppBar(
        title: const SharedAppBar(),
        toolbarHeight: Get.height * 0.2,
        actions: null,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.file(
              logic.imgFile!,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(12.0),
            width: Get.width,
            height: Get.height * 0.15,
            decoration: BoxDecoration(
              color: result ?const Color.fromRGBO(112,141,83,0.8) : const Color.fromRGBO(244,80,80,0.7),
              border: Border.all(
                width: 5,
                color: result ? const Color.fromRGBO(55, 139, 37, 1) : const Color.fromRGBO(152,18,18,1),
              ),
              borderRadius: BorderRadius.circular(6.0)
            ),
            child: Text(message, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          )
        ],
      ),
    );
  }
}
