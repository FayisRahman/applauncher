import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  AddTextField({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 20),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Family Name",
              hintStyle: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
