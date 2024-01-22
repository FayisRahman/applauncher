import 'package:applauncher/widgets/add_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../data_response/data_response.dart';

class AddFamily extends StatelessWidget {
  static const String id = "Add Family";
  final TextEditingController controller = TextEditingController();
  List<String>? familyList = [];

  AddFamily({super.key});

  String familyName = "";

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
                    familyName = data;
                  },
                  controller: controller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final pref = provider.Provider.of<DataResponse>(context,
                                listen: false)
                            .pref;
                        List<String>? familyList =
                            pref?.getStringList("familyList") ?? [];
                        familyList.add(familyName);
                        await pref?.setStringList("familyList", familyList);
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
