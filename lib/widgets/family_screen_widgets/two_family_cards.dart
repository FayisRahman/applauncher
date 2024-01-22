import 'package:applauncher/widgets/family_screen_widgets/family_card_button.dart';
import 'package:flutter/material.dart';

class TwoFamilyCard extends StatelessWidget {
  final String nameOne;
  final String nameTwo;

  const TwoFamilyCard(
      {super.key, required this.nameOne, required this.nameTwo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FamilyCard(
            familyName: nameOne,
          ),
          const SizedBox(
            width: 10,
          ),
          FamilyCard(
            familyName: nameTwo,
          ),
        ],
      ),
    );
  }
}
