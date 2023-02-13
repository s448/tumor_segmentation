import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tumer_segmentation/model/response.dart' hide Image;
import 'package:url_launcher/url_launcher.dart';
class ResultPage extends StatefulWidget {
  ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ResponseModel? data ;
  var url;
@override
  void initState() {
   data = Get.arguments;
   url =Uri.parse(data!.data!.image!.url.toString());
   print(url);
   print(data!.data!.image!.url.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print(Get.arguments);
    return Scaffold(
      appBar: AppBar(title: const Text("Result Page"),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(data!.success == true ? "Successful request" : "Request Failed"),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(data!.data!.image!.url.toString()),
          ),
          TextButton(onPressed: ()async{
            if (!await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
            webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
            )) {
            throw Exception('Could not launch $url');
            }
          }, child:const Text("رابط الصورة عالسيرفر"))
        ],
      )
    );
  }
}
