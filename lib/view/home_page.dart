import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumer_segmentation/components/app_bar.dart';
import 'package:tumer_segmentation/components/shared_button.dart';
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
                  title: const SharedAppBar(), toolbarHeight: Get.height * 0.2),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12.0),
                      child: !selected
                          ? Column(
                              children: [
                                const SizedBox(height: 50),
                                const IntrinsicHeight(
                                  child: Text(
                                    "Upload the Brain MRI image",
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      CustomButton(
                                        action: (() {
                                          debugPrint("Camera");
                                          logic.selectImgFromGallery(
                                              true);
                                          Get.back();
                                        }),
                                        buttonText: "Camera",
                                        ic: const Icon(Icons.camera_alt),
                                      ),
                                      CustomButton(
                                        action: (() {
                                          debugPrint("Gallery");
                                          logic.selectImgFromGallery(
                                              false);
                                          Get.back();
                                        }),
                                        buttonText: "Gallery",
                                        ic: const Icon(Icons.image_outlined),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Stack(children: [
                              Image.file(
                                logic.imgFile!,
                                fit: BoxFit.cover,
                                width: Get.width *0.8,
                              ),
                              Positioned(
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: IconButton(
                                    onPressed: (() {
                                      logic.removeImg();
                                    }),
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red.shade700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                          child: selected
                              ? SizedBox(
                                  width: Get.width,
                                  child: ElevatedButton(
                                    onPressed: (() {
                                      logic.uploadImgToServer();
                                    }),
                                    child: logic.uploading
                                        ? const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text("Upload"),
                                  ),
                                )
                              : const SizedBox()),
                    ),
                  ],
                ),
              ));
        });
  }
}
