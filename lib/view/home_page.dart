import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/upload_mri_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logic = Get.put(UploadMRIController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadMRIController>(
        init: UploadMRIController(),
        builder: (context) {
          bool selected = logic.imgFile != null;
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Tumor Detection"),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    child: !selected
                        ? Column(
                            children: [
                              const IntrinsicHeight(
                                child: Text(
                                  "Click here to select the Brain MRI : ",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              InkWell(
                                  onTap: (() {
                                    logic.selectImgFromGallery();
                                  }),
                                  child: CircleAvatar(
                                    radius: Get.width * 0.2,
                                    child: Image.asset(
                                      "assets/brain.png",
                                      width: Get.width * 0.5,
                                      height: Get.height * 0.4,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ))
                            ],
                          )
                        : Image.file(
                            logic.imgFile!,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Center(
                      child: selected
                          ? ElevatedButton(
                              onPressed: (() {
                                selected
                                    ? logic.uploadImgToServer()
                                    : logic.selectImgFromGallery();
                              }),
                              child: Text(selected
                                  ? "Upload MRI for processing"
                                  : "Select another MRI from Gallery"),
                            )
                          : const SizedBox()),
                  logic.uploading ? CircularProgressIndicator() : SizedBox()
                ],
              ));
        });
  }
}
