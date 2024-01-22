import 'package:applauncher/screens/add_family_screen.dart';
import 'package:applauncher/widgets/add_buttons/add_button.dart';
import 'package:applauncher/widgets/add_buttons/family_and_add_button.dart';
import 'package:applauncher/widgets/add_buttons/one_add_button.dart';
import 'package:applauncher/widgets/family_screen_widgets/family_card_button.dart';
import 'package:applauncher/widgets/family_screen_widgets/two_family_cards.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart' as provider;

import '../data_response/data_response.dart';

class FamilyScreen extends StatefulWidget {
  static const String id = "Family Screen";

  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  SharedPreferences? pref;

  List<String> familyNames = [];
  List<Widget> family = [];

  void setFamilyList() {
    family = [];
    familyNames = pref!.getStringList("familyList") ?? [];
    int length = familyNames.length;
    if (length == 0) {
      family.add(AddButton(onReturn: setFamilyList, screenName: AddFamily.id));
      return;
    }
    int flag = 0;
    if (length % 2 == 1) {
      length--;
      flag = 1;
    }
    for (int i = 0; i < length; i++) {
      family.add(TwoFamilyCard(
        nameOne: familyNames[i],
        nameTwo: familyNames[++i],
      ));
    }
    if (flag == 1) {
      family.add(
        FamilyAddButton(
          name: familyNames[length],
          onReturn: setFamilyList,
          isContact: false,
          screenName: AddFamily.id,
        ),
      );
    } else {
      family.add(
        OneAddButton(
          onReturn: setFamilyList,
          screenName: AddFamily.id,
        ),
      );
    }
    setState(() => family);
  }

  @override
  void initState() {
    pref = provider.Provider.of<DataResponse>(context, listen: false).pref!;
    setFamilyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: family),
            ),
          ],
        ),
      ),
    );
  }
}
