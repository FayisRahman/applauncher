import 'package:applauncher/screens/add_contact_screen.dart';
import 'package:applauncher/widgets/add_buttons/family_and_add_button.dart';
import 'package:applauncher/widgets/add_buttons/one_add_button.dart';
import 'package:applauncher/widgets/contact_screen_widgets/conatct_card_button.dart';
import 'package:applauncher/widgets/contact_screen_widgets/two_contact_cards.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data_response/data_response.dart';
import '../widgets/add_buttons/add_button.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  static const String id = "Contact Screen";

  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Widget> contactList = [];
  SharedPreferences? _prefs;
  String? familyName;

  void setContactList() {
    contactList = [];
    List<String>? contactNameList =
        _prefs?.getStringList("$familyName/contactName") ?? [];
    List<String>? contactNumList =
        _prefs?.getStringList("$familyName/contactNum") ?? [];
    int length = contactNumList.length;
    if (length == 0) {
      contactList
          .add(AddButton(onReturn: setContactList, screenName: AddContact.id));
      return;
    }
    int flag = 0;
    if (length % 2 == 1) {
      length--;
      flag++;
    }
    for (int i = 0; i < length; i += 2) {
      contactList.add(
        TwoContactCard(
          nameOne: contactNameList![i],
          nameTwo: contactNameList[i + 1],
          numOne: contactNumList[i],
          numTwo: contactNumList[i + 1],
        ),
      );
    }
    if (flag == 1) {
      contactList.add(
        FamilyAddButton(
          name: contactNameList![length],
          onReturn: setContactList,
          isContact: true,
          screenName: AddContact.id,
        ),
      );
    } else {
      contactList.add(OneAddButton(
        onReturn: setContactList,
        screenName: AddContact.id,
      ));
    }
    setState(() => contactList);
  }

  @override
  void initState() {
    _prefs = Provider.of<DataResponse>(context, listen: false).pref!;
    familyName = Provider.of<DataResponse>(context, listen: false).familyName;
    setContactList();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contactList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
