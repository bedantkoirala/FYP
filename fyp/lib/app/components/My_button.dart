import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  final String tittle;
  final bool isDisabled;
  final void Function()? onPressed;
  const MyButton(
      {super.key,
      required this.tittle,
      this.onPressed,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isDisabled ? null : onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: isDisabled
                  ? const Color(0xFFB0B0B0)
                  : const Color(0xFF07364A),
              borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: Get.width,
          child: Center(
              child: Text(
            tittle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )),
        ));
  }
}
