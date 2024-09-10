import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/api_calls.dart';

class AddJournal extends StatelessWidget {
  const AddJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextEditingController title_controller = TextEditingController();
    final TextEditingController entry_controller =
    TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Add Journal Entry',
          maxLines: 2,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        controller: title_controller,
                        readOnly: false,
                        textFieldType: TextFieldType.NAME,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: entry_controller,
                        readOnly: false,
                        maxLines: 20,
                        decoration: InputDecoration(
                          labelText: 'Entry',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      FloatingActionButton.extended(
                        backgroundColor: Colors.white,
                        onPressed: () async {
                          if (title_controller.text.trim() == '') {
                            toasty(context, 'Please enter a title');
                          } else if (entry_controller.text.trim() == '') {
                            toasty(context, 'Please enter a journal entry');
                          } else {
                            var user_email = FirebaseAuth.instance.currentUser?.email;

                            await addJournalEntry(user_email!, title_controller.text.trim(),
                                entry_controller.text.trim())
                                .then((value) async {
                              toasty(context, value['message']);
                              if(value['message'] == 'Success'){
                                Navigator.pushNamed(context, '/journal');

                              }
                              // finish(context);
                              // controller!.dispose();
                            }).catchError((e) {
                              toasty(context, e.toString());
                            });
                          }
                        },
                        heroTag: 'save',
                        elevation: 0,
                        label: const Text("Save Entry"),
                        icon: const Icon(Icons.save),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
