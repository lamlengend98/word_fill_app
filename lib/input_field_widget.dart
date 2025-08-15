import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const InputFieldWidget({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // full width
      decoration: BoxDecoration(
        color: Colors.white, // background white
        borderRadius: BorderRadius.circular(16), // radius 16
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25), // black shadow
            blurRadius: 6,
            offset: Offset(0, 3), // position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
          labelText: labelText,
        ),
      ),
    );
  }
}
