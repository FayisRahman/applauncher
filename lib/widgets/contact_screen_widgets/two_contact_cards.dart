import 'package:applauncher/widgets/contact_screen_widgets/conatct_card_button.dart';
import 'package:flutter/material.dart';

class TwoContactCard extends StatelessWidget {
  final String nameOne;final String nameTwo;final String numOne;final String numTwo;
  const TwoContactCard({super.key, required this.nameOne, required this.nameTwo, required this.numOne, required this.numTwo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ContactCard(contactName: nameOne, number: numOne,),
          const SizedBox(
            width: 10,
          ),
          ContactCard(contactName: nameTwo, number: numTwo,),
        ],
      ),
    );
  }
}
