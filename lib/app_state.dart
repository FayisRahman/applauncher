import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

const platform = MethodChannel('launcher_channel');

Future<void> showLauncherDialog() async {
  try {
    await platform.invokeMethod('showLauncherDialog');
  } on PlatformException catch (e) {
    print("Failed to show launcher dialog: ${e.message}");
  }
}

Future<void> notifyUserChoice(bool sate) async {
  try {
    await platform.invokeMethod('onUserChoice');
  } on PlatformException catch (e) {
    throw 'Error: ${e.message}';
  }
}

final appsProviderSystem = FutureProvider<List>(
    (ref) => DeviceApps.getInstalledApplications(includeAppIcons: true));
final appsProvider = FutureProvider<List>((ref) =>
    DeviceApps.getInstalledApplications(
        includeAppIcons: true, includeSystemApps: true));
