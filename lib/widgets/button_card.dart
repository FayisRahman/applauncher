import 'package:android_intent_plus/android_intent.dart';
import 'package:applauncher/app_state.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  const CardButton({super.key, required this.packageName, required this.icon});

  final String packageName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35)),
        onPressed: () {
          AndroidIntent intent = const AndroidIntent(
            action: "android.settings.APPLICATION_DETAILS_SETTINGS",
            package: "com.android.settings",
            data: "package:com.package.com.applauncher",
          );
          intent.launch();
          // print(appsProviderSystem.dependencies);
          // DeviceApps.openApp(packageName);
        },
        child: Icon(
          icon,
          size: 50,
        ));
  }
}
