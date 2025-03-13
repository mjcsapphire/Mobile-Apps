import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/api_calls.dart';

class AddJournal extends StatelessWidget {
  const AddJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController entryController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add Journal Entry',
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                        controller: titleController,
                        readOnly: false,
                        textFieldType: TextFieldType.NAME,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: entryController,
                        readOnly: false,
                        maxLines: 20,
                        decoration: const InputDecoration(
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
                          if (titleController.text.trim() == '') {
                            toasty(context, 'Please enter a title');
                          } else if (entryController.text.trim() == '') {
                            toasty(context, 'Please enter a journal entry');
                          } else {
                            var userEmail =
                                FirebaseAuth.instance.currentUser?.email;

                            await addJournalEntry(
                                    userEmail!,
                                    titleController.text.trim(),
                                    entryController.text.trim())
                                .then((value) async {
                              toasty(context, value['message']);
                              if (value['message'] == 'Success') {
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
