import 'package:flutter/cupertino.dart';

import 'add_button.dart';

class OneAddButton extends StatelessWidget {
  final VoidCallback onReturn;
  final String screenName;

  const OneAddButton(
      {super.key, required this.onReturn, required this.screenName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: AddButton(
              onReturn: onReturn,
              screenName: screenName,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
