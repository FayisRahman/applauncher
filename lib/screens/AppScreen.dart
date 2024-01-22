import 'package:applauncher/app_state.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modeProvider = StateProvider<DisplayMode>((ref) => DisplayMode.Grid);

enum DisplayMode {
  Grid,
  List,
}

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  static const String id = "AppScreen";

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final appsInfo = watch;
      final mainMode = watch;
      final mode = mainMode.watch(modeProvider);
      final AppsInfo = appsInfo.watch(appsProvider);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: AppsInfo.when(
          data: (List apps) => GridView.builder(
            itemCount: apps.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
            itemBuilder: (context, index) {
              ApplicationWithIcon app = apps[index];
              return AppGridItem(app: app);
            },
          ),
          error: (err, trace) => Container(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    });
  }
}

class AppGridItem extends StatelessWidget {
  final ApplicationWithIcon app;

  const AppGridItem({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(app.packageName);
        DeviceApps.openApp(app.packageName);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Image.memory(
              app.icon,
              fit: BoxFit.contain,
              width: 40,
            ),
          ),
          Text(
            app.packageName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
