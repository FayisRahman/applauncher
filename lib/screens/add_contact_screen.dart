import 'package:applauncher/widgets/add_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_response/data_response.dart';

class AddContact extends StatelessWidget {
  static const String id = "Add Contact";
  List<String>? familyList = [];
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  AddContact({super.key});

  String contactName = "";
  String number = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: const Icon(
                    Icons.home,
                    size: 60,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                AddTextField(
                  onChanged: (data) {
                    contactName = data;
                  },
                  controller: controller1,
                ),
                AddTextField(
                  onChanged: (data) {
                    number = data;
                  },
                  controller: controller2,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final pref =
                            Provider.of<DataResponse>(context, listen: false)
                                .pref;
                        final familyName =
                            Provider.of<DataResponse>(context, listen: false)
                                .familyName;
                        List<String>? contactNameList =
                            pref?.getStringList("$familyName/contactName") ??
                                [];
                        List<String>? contactNumList =
                            pref?.getStringList("$familyName/contactNum") ?? [];
                        contactNameList.add(contactName);
                        contactNumList.add(number);
                        await pref?.setStringList(
                            "$familyName/contactName", contactNameList);
                        await pref?.setStringList(
                            "$familyName/contactNum", contactNumList);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.40,
                          MediaQuery.of(context).size.width * 0.40,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: MediaQuery.of(context).size.width * 0.30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.40,
                          MediaQuery.of(context).size.width * 0.40,
                        ),
                      ),
                      child: Icon(
                        Icons.close,
                        size: MediaQuery.of(context).size.width * 0.30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
