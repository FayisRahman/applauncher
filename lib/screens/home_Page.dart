import 'package:android_intent_plus/android_intent.dart';
import 'package:applauncher/screens/family_screen.dart';
import 'package:applauncher/widgets/home_page_widgets/button_card.dart';
import 'package:applauncher/widgets/home_page_widgets/two_card_button.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_mode/sound_mode.dart';
import '../app_state.dart';
import '../data_response/data_response.dart';
import 'AppScreen.dart';
import 'package:provider/provider.dart' as provider;
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class MyHomePage extends StatefulWidget {
  static const String id = "HomeScreen";

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  // TorchController torchController = TorchController();
  // void showLauncherDialog() {
  //   notifyUserChoice(false); // Pass `true` if the app is set as the launcher
  // }
  final MethodChannel _platform = const MethodChannel("launcher/flash");
  final MethodChannel _launcherPlatform =
      const MethodChannel("launcher/launcher_popup");
  IconData? torchState;
  double currentBrightness = 0;
  double maxBrightness = 0;
  ScreenBrightness screenBrightness = ScreenBrightness();
  double? currVolume;
  IconData? volIcon;
  RingerModeStatus? ringerStatus = RingerModeStatus.normal;

  void defaultAct() async {
    await _launcherPlatform.invokeMethod("launcher_popup");
  }

  void openCameraApp() {}
  SharedPreferences? pref;

  Future<void> getPref() async {
    pref = await SharedPreferences.getInstance();
    context.mounted
        ? provider.Provider.of<DataResponse>(context, listen: false)
            .setPref(pref!)
        : null;
    currentBrightness = await screenBrightness.current;
    maxBrightness = await screenBrightness.system;
    ringerStatus = await SoundMode.ringerModeStatus;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    WidgetsBinding.instance.addObserver(this);
    defaultAct();
    // showLauncherDialog();
  }

  void setIcon() {
    setState(() {
      if (ringerStatus == RingerModeStatus.normal) {
        volIcon = Icons.volume_up;
      } else if (ringerStatus == RingerModeStatus.silent) {
        volIcon = Icons.volume_off;
      } else if (ringerStatus == RingerModeStatus.vibrate) {
        volIcon = Icons.vibration;
      }
    });
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
      // showLauncherDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CardButton(
                  icon: const Icon(Icons.perm_contact_cal, size: 50),
                  onPressed: () {
                    Navigator.pushNamed(context, FamilyScreen.id);
                  }),
            ),
            TwoCardButton(
              onPressedOne: () {
                const intent = AndroidIntent(
                  action: 'android.intent.action.DIAL',
                );
                intent.launch();
              },
              onPressedTwo: () {
                const intent = AndroidIntent(
                  action: 'android.media.action.STILL_IMAGE_CAMERA',
                );
                intent.launch();
              },
              iconOne: const Icon(Icons.phone, size: 50),
              iconTwo: const Icon(Icons.camera_alt, size: 50),
            ),
            TwoCardButton(
              onPressedOne: () {
                _platform.invokeMethod("toggleFlash");
              },
              onPressedTwo: () async {
                if (ringerStatus == RingerModeStatus.normal) {
                  ringerStatus = RingerModeStatus.vibrate;
                } else if (ringerStatus == RingerModeStatus.vibrate) {
                  ringerStatus = RingerModeStatus.silent;
                } else if (ringerStatus == RingerModeStatus.silent) {
                  ringerStatus = RingerModeStatus.normal;
                }
                setIcon();
                await SoundMode.setSoundMode(ringerStatus!);
              },
              iconOne: const Icon(
                Icons.flashlight_on,
                size: 50,
              ),
              iconTwo: Icon(volIcon, size: 50),
            ),
            TwoCardButton(
              onPressedOne: () async {
                currentBrightness = await screenBrightness.current;
                if (currentBrightness == maxBrightness) {
                  await screenBrightness
                      .setScreenBrightness(maxBrightness * 0.5);
                } else if (currentBrightness < maxBrightness &&
                    currentBrightness >= maxBrightness * 0.5) {
                  await screenBrightness
                      .setScreenBrightness(maxBrightness * 0.1);
                } else if (currentBrightness < maxBrightness * 0.5 &&
                    currentBrightness >= 0) {
                  await screenBrightness
                      .setScreenBrightness(maxBrightness * 0.1);
                }
              },
              onPressedTwo: () {
                const intent = AndroidIntent(
                  action: 'android.settings.SETTINGS',
                );
                intent.launch();
              },
              iconOne: StreamBuilder<double>(
                stream: screenBrightness.onCurrentBrightnessChanged,
                builder: (context, snapshot) {
                  double changedBrightness = currentBrightness;
                  if (snapshot.hasData) {
                    changedBrightness = snapshot.data!;
                  }
                  if (changedBrightness == maxBrightness) {
                    return const Icon(
                      Icons.brightness_7,
                      size: 50,
                    );
                  } else if (changedBrightness < maxBrightness &&
                      changedBrightness >= maxBrightness * 0.5) {
                    return const Icon(
                      Icons.brightness_6_rounded,
                      size: 50,
                    );
                  } else if (changedBrightness <= maxBrightness * 0.5 &&
                      changedBrightness >= 0) {
                    return const Icon(
                      Icons.brightness_low_sharp,
                      size: 50,
                    );
                  }
                  return const Icon(
                    Icons.brightness_7,
                    size: 50,
                  );
                },
              ),
              iconTwo: const Icon(Icons.settings, size: 50),
            ),
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
