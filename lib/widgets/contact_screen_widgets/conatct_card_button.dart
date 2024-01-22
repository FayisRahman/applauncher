import 'package:android_intent_plus/android_intent.dart';
import 'package:applauncher/screens/contact_screen.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final String contactName;
  final String number;

  const ContactCard(
      {super.key, required this.contactName, required this.number});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35)),
        onPressed: () {
          AndroidIntent intent = AndroidIntent(
            action: 'android.intent.action.CALL',
            data: "tel:$number",
          );
          intent.launch();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Icon(
                Icons.person,
                size: 50,
              ),
              Text(
                contactName,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
