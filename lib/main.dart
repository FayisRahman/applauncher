import 'package:applauncher/data_response/data_response.dart';
import 'package:applauncher/screens/AppScreen.dart';
import 'package:applauncher/screens/add_contact_screen.dart';
import 'package:applauncher/screens/add_family_screen.dart';
import 'package:applauncher/screens/contact_screen.dart';
import 'package:applauncher/screens/family_screen.dart';
import 'package:applauncher/screens/home_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart' as provider;

// import 'package:android_intent_plus/android_intent.dart';
// import 'package:torch_controller/torch_controller.dart';
// import 'app_state.dart';
// import 'package:device_apps/device_apps.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.phone.request();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return provider.ChangeNotifierProvider<DataResponse>(
      create: (context) => DataResponse(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: MyHomePage.id,
        routes: {
          MyHomePage.id: (context) => const MyHomePage(),
          AppScreen.id: (context) => const AppScreen(),
          ContactScreen.id: (context) => const ContactScreen(),
          FamilyScreen.id: (context) => const FamilyScreen(),
          AddFamily.id: (context) => AddFamily(),
          AddContact.id: (context) => AddContact(),
        },
      ),
    );
  }
}
