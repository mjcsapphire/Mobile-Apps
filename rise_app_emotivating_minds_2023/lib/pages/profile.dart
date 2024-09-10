import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rise_app_emotivating_minds_2023/pages/signin_screen.dart';
import 'package:rise_app_emotivating_minds_2023/theme/colors.dart';
import '../models/user_model.dart';
import '../utils/api_calls.dart';
import 'image_uploader.dart';

class ProfilePage extends StatelessWidget {
  final UserModel data;
  const ProfilePage({Key? key, required this.data}) : super(key: key);

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        FirebaseAuth.instance.signOut().then((value) {
          print("Signed Out");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInScreen()));
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation Alert"),
      content: Text("Would you like to logout?"),
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
    final TextEditingController firstname_controller = TextEditingController();
    final TextEditingController surname_controller =
    TextEditingController();
    final TextEditingController email_controller =
    TextEditingController();

    firstname_controller.text = data.firstname!;
    surname_controller.text = data.surname!;
    email_controller.text = data.user_email!;

    final destination = data.mobile_app_profile_pic?.toString() ?? 'https://www.sapphirearts.co.uk//clients//riseapp//uploads//images//default.png';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(height: 250, child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.white, primaryColor]),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(destination),
                            ),

                          )
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
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
                      controller: firstname_controller,
                      readOnly: false,
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        labelText: 'Firstname',
                        hintText: data.firstname,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      controller: surname_controller,
                      readOnly: false,
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        hintText: data.surname,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    AppTextField(
                      controller: email_controller,
                      readOnly: true,
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: data.user_email,
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
                        if (firstname_controller.text.trim() == '') {
                          toasty(context, 'Please enter a firstname');
                        } else if (surname_controller.text.trim() == '') {
                          toasty(context, 'Please enter a surname');
                        } else {
                          var user_email = FirebaseAuth.instance.currentUser?.email;

                          await updateUser(user_email!, firstname_controller.text.trim(),
                              surname_controller.text.trim())
                              .then((value) async {
                            toasty(context, value['message']);
                            // if(value['message'] == 'Success'){
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => const vCardsScreen()),
                            //   );
                            //
                            // }
                            // finish(context);
                            // controller!.dispose();
                          }).catchError((e) {
                            toasty(context, e.toString());
                          });
                        }
                      },
                      heroTag: 'save',
                      elevation: 0,
                      label: const Text("Save Details"),
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
                    Accordion(
                      maxOpenSections: 2,
                      headerBackgroundColorOpened: Colors.black54,
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 15),
                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      children: [
                        AccordionSection(
                          isOpen: false,
                          leftIcon:
                          const Icon(Icons.crisis_alert, color: Colors.white),
                          headerBackgroundColor: Colors.black,
                          headerBackgroundColorOpened:
                          primaryColor,
                          header: Text('My Toolkit', style: TextStyle(color: Colors.white),),
                          content: Column(
                            children: [
                              FloatingActionButton.extended(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/toolkitSound');
                                },
                                heroTag: 'picture',
                                elevation: 0,
                                label: const Text("Change Rise Sound"),
                                icon: const Icon(Icons.music_note),
                              ),
                              const SizedBox(height: 20),
                              FloatingActionButton.extended(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/toolkitImage');
                                },
                                heroTag: 'picture',
                                elevation: 0,
                                label: const Text("Change Rise Visual"),
                                icon: const Icon(Icons.camera_alt),
                              ),

                            ],
                          ),
                          contentHorizontalPadding: 20,
                          contentBorderWidth: 1,
                          // onOpenSection: () => print('onOpenSection ...'),
                          // onCloseSection: () => print('onCloseSection ...'),
                        ),
                      ],
                    ),
                    Accordion(
                      maxOpenSections: 2,
                      headerBackgroundColorOpened: Colors.black54,
                      scaleWhenAnimating: true,
                      openAndCloseAnimation: true,
                      headerPadding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 15),
                      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                      sectionClosingHapticFeedback: SectionHapticFeedback.light,
                      children: [
                        AccordionSection(
                          isOpen: false,
                          leftIcon:
                          const Icon(Icons.pending_actions, color: Colors.white),
                          headerBackgroundColor: Colors.black,
                          headerBackgroundColorOpened:
                          primaryColor,
                          header: Text('Other Actions', style: TextStyle(color: Colors.white),),
                          content: Column(
                            children: [
                              FloatingActionButton.extended(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ImageUpload(data: data)),

                                  );
                                },
                                heroTag: 'picture',
                                elevation: 0,
                                label: const Text("Change Profile Picture"),
                                icon: const Icon(Icons.camera),
                              ),
                              const SizedBox(height: 20),
                              FloatingActionButton.extended(
                                backgroundColor: Colors.grey,
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                heroTag: 'remove',
                                elevation: 0,
                                label: const Text("Logout"),
                                icon: const Icon(Icons.logout),
                              ),
                            ],
                          ),
                          contentHorizontalPadding: 20,
                          contentBorderWidth: 1,
                          // onOpenSection: () => print('onOpenSection ...'),
                          // onCloseSection: () => print('onCloseSection ...'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoItem {
  final String title;
  final String value;
  ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white, primaryColor]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://www.sapphirearts.co.uk//clients//riseapp//uploads//images//default.png'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
