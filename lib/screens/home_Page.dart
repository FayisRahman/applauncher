import 'package:applauncher/widgets/button_card.dart';
import 'package:applauncher/widgets/two_card_button.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import '../app_state.dart';
import 'AppScreen.dart';

class MyHomePage extends StatefulWidget {
  static const String id = "HomeScreen";

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  // TorchController torchController = TorchController();
  void showLauncherDialog() {
    notifyUserChoice(false); // Pass `true` if the app is set as the launcher
  }

  IconData? torchState;

  // void torchStateIcon() async{
  //       if(await torchController.isTorchActive == true){
  //         torchState = Icons.light_mode_rounded;
  //       }else{
  //
  //       }
  // }
  // void findApp(String appName){
  //   for(Application app in){
  //
  //   }
  // }
  void openCameraApp() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    showLauncherDialog();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Check if the app is set as the default launcher when it is resumed
      showLauncherDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TwoCardButton(),
            TwoCardButton(),
            TwoCardButton(),
            TwoCardButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.pushNamed(context, AppScreen.id);
        },
        child: const Icon(
          Icons.apps,
          color: Colors.white,
          size: 35,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
