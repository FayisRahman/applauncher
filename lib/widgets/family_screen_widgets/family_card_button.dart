import 'package:applauncher/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data_response/data_response.dart';

class FamilyCard extends StatelessWidget {
  const FamilyCard({super.key, required this.familyName});

  final String familyName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35)),
        onPressed: () {
          Provider.of<DataResponse>(context, listen: false)
              .setFamilyName(familyName);
          Navigator.pushNamed(context, ContactScreen.id);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Icon(
                Icons.house_outlined,
                size: 50,
              ),
              Text(
                familyName,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
