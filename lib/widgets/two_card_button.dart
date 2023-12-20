import 'package:flutter/material.dart';
import 'button_card.dart';

class TwoCardButton extends StatelessWidget {
  const TwoCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CardButton(packageName: "com.huawei.camera", icon: Icons.camera_alt),
          CardButton(packageName: "com.android.settings", icon: Icons.settings),
        ],
      ),
    );
  }
}
