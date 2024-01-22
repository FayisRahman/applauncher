import 'package:applauncher/screens/add_family_screen.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onReturn;
  final String screenName;

  const AddButton(
      {super.key, required this.onReturn, required this.screenName});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 3, color: Colors.grey),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35)),
      onPressed: () async {
        await Navigator.pushNamed(context, screenName);
        onReturn();
      },
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}
