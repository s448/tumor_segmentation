import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedAppBar extends StatelessWidget {
  const SharedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        color: Colors.indigo,
        width: Get.width,
        padding: const EdgeInsets.all(3.0),
        margin: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/fci_zu_logo.jpg",
              width: Get.width * 0.2,
              fit: BoxFit.fill,
            ),
            const Expanded(
              child:  Text(
                "Machine Learning-based Tumor Segmentation for MRI images",
                softWrap: true,
                maxLines: 8,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              "assets/zu_logo.png",
              width: Get.width * 0.2,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
