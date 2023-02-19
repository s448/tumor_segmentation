import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.buttonText, required this.action}) : super(key: key);
  final String buttonText;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: SizedBox(
          width: Get.width,
          child: ElevatedButton(
              onPressed: (action),
              child: Text(buttonText)),
        ),
      ),
    );
  }
}
