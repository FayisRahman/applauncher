import 'package:applauncher/widgets/add_buttons/add_button.dart';
import 'package:applauncher/widgets/contact_screen_widgets/conatct_card_button.dart';
import 'package:flutter/cupertino.dart';
import '../family_screen_widgets/family_card_button.dart';

class FamilyAddButton extends StatelessWidget {
  final String name;
  final VoidCallback onReturn;
  final bool isContact;
  String number;
  final String screenName;

  FamilyAddButton(
      {super.key,
      required this.name,
      required this.onReturn,
      required this.isContact,
      this.number = "",
      required this.screenName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          isContact
              ? ContactCard(contactName: name, number: number)
              : FamilyCard(
                  familyName: name,
                ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: AddButton(
              onReturn: onReturn,
              screenName: screenName,
            ),
          ),
        ],
      ),
    );
  }
}
