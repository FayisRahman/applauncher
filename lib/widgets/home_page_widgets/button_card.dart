import 'package:android_intent_plus/android_intent.dart';
import 'package:applauncher/app_state.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardButton extends StatelessWidget {
  const CardButton({super.key, required this.icon, required this.onPressed});

  final Widget icon;
  final void Function() onPressed;

  // void openCamera() {
  //   android_intent.Intent()
  //     ..setAction(android_action.Action.camera)
  //     ..startActivity().catchError((e) => print('Error opening camera: $e'));
  // }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35)),
        onPressed: onPressed,
        child: icon);
  }
}
