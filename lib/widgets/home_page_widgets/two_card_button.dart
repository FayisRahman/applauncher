import 'package:flutter/material.dart';
import 'button_card.dart';

class TwoCardButton extends StatelessWidget {
  const TwoCardButton({
    super.key,
    required this.onPressedOne,
    required this.onPressedTwo,
    required this.iconOne,
    required this.iconTwo,
  });

  final void Function() onPressedOne;
  final void Function() onPressedTwo;
  final Widget iconOne;
  final Widget iconTwo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: CardButton(
              icon: iconOne,
              onPressed: onPressedOne,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: CardButton(
              icon: iconTwo,
              onPressed: onPressedTwo,
            ),
          ),
        ],
      ),
    );
  }
}
