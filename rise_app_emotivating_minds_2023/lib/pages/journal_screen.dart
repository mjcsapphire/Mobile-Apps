import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/api_calls.dart';
import 'add_journal_page.dart';
import 'edit_journal_page.dart';


dynamic journalController = "";
var journalList = [].obs;

class JournalEntriesPage extends StatefulWidget {
  const JournalEntriesPage({Key? key}) : super(key: key);

  @override
  State<JournalEntriesPage> createState() => _JournalEntriesPageState();
}

class _JournalEntriesPageState extends State<JournalEntriesPage> {


  _fetchJournalEntries() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var user_email = FirebaseAuth.instance.currentUser?.email;
        var Entries = await HttpService.fetchJournalEntries(user_email);
        if (Entries != null) {
          journalList.value = Entries;
        }else{
          return 'No entries found';

        }
      }
    } on SocketException catch (_) {
      print('No Internet');
      return 'No entries found';
    }

    return journalList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {Navigator.pushNamed(context, '/home');},
          icon: Icon(Icons.chevron_left),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
    title: Text(
    'My Journal',
    maxLines: 2,
    style: TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold),
    ),

    ),
    body:
    Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            FloatingActionButton.extended(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddJournal(),),

                );
              },
              heroTag: 'save',
              elevation: 0,
              label: const Text("Add New Journal Entry"),
              icon: const Icon(Icons.add),
            ),
            SizedBox(height: 10,),
            const Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
              child: Divider(color: Colors.blue,),
            ),
            SizedBox(height: 10,),
            FutureBuilder(
                future: _fetchJournalEntries(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Text('No journal entries made');
                  } else {

                    return Expanded(
                      child: ListView.builder(
                        itemCount: journalList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Material(
                                  elevation: 2.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EditJournal(journal: journalList[index]),),

                                      );
                                    },
                                    child: Container(
                                      width:
                                      MediaQuery.of(context).size.height,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.blue,
                                            width: 3.0,
                                          ),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            journalList[index].title,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                          Text(
                                            journalList[index].date,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
            ),
          ],
        ),
      ),
    ),);
  }
}
