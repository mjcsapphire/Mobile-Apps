import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rise_app_emotivating_minds_2023/models/journal_model.dart';

import '../utils/api_calls.dart';

class EditJournal extends StatelessWidget {
  final JournalModel journal;

  const EditJournal({Key? key, required this.journal}) : super(key: key);

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        await deleteJournalEntry(journal.id!).then((value) async {
          toasty(context, value['message']);
          if (value['message'] == 'Success') {
            print("Deleted");
            Navigator.pop(context);
            Navigator.pushNamed(context, '/journal');
          }
          // finish(context);
          // controller!.dispose();
        }).catchError((e) {
          toasty(context, e.toString());
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirmation Alert"),
      content: const Text("Are you sure you'd like to delete this entry?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController entryController = TextEditingController();

    titleController.text = journal.title!;
    entryController.text = journal.entry!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Edit Entry',
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
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: journal.title,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: entryController,
                        readOnly: false,
                        maxLines: 20,
                        decoration: InputDecoration(
                          labelText: 'Entry',
                          hintText: journal.entry,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: const OutlineInputBorder(),
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
                            await updateJournalEntry(
                                    journal.id!,
                                    titleController.text.trim(),
                                    entryController.text.trim())
                                .then((value) async {
                              toasty(context, value['message']);
                              if (value['message'] == 'Success') {
                                // Navigator.pop(context);
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
                      const Divider(
                        height: 100,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey,
                      ),
                      FloatingActionButton.extended(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        heroTag: 'remove',
                        elevation: 0,
                        label: const Text("Delete Entry"),
                        icon: const Icon(Icons.delete),
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
