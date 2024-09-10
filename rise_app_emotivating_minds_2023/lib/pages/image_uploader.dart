import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rise_app_emotivating_minds_2023/theme/colors.dart';

import '../models/user_model.dart';
import '../utils/api_calls.dart';

class ImageUpload extends StatefulWidget{
  final UserModel data;
  const ImageUpload({Key? key, required this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ImageUpload();
  }
}
class _ImageUpload extends State<ImageUpload>{
  final ImagePicker _picker = ImagePicker();
  File? uploadimage;
  String? imageName = '';

  Future<void> chooseImage() async {
    var choosedimage = await _picker.pickImage(source: ImageSource.gallery);
    print(choosedimage?.name);
    imageName = choosedimage?.name;
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }
  Future<void> uploadImage() async {
    setState(() {
      _isLoading=true;
    });
    var uploadurl = Uri.parse('https://www.risepathway.com/scripts/uploadimage?user_email=${widget.data.user_email}&filename=$imageName');
    try{
      List<int> imageBytes = uploadimage!.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(
          uploadurl,
          body: {
            'image': baseimage,
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body);
        if(jsondata["error"]){
          print(jsondata["msg"]);
        }else{
          print("Upload successful");

          await uploadImageAPI(widget.data.user_email.toString(), imageName!)
              .then((value) async {
            toasty(context, value['message']);
            if(value['message'] == 'Success'){
              setState(() {
                _isLoading=false;
              });
              Navigator.pushNamed(context, '/home');

            }
            // finish(context);
            // controller!.dispose();
          }).catchError((e) {
            toasty(context, e.toString());
          });
        }
      }else{
        print("Error during connection to server");
      }
    }catch(e){
      print("Error during converting to Base64");
    }
  }

  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Upload Profile Picture"),),
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.white,
      body:Container(
        height:300,
        alignment: Alignment.center,
        child:_isLoading
            ?const CircularProgressIndicator()
            :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child:uploadimage == null?
                Container():
                SizedBox(
                    height:150,
                    child:Image.file(uploadimage!)
                )
            ),

            Container(
                child:uploadimage == null?
                Container():
                ElevatedButton.icon(
                  onPressed: (){
                    uploadImage();
                  },
                  icon: const Icon(Icons.file_upload),
                  label: const Text("UPLOAD IMAGE"),
                )
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              onPressed: (){
                chooseImage();
              },
              icon:const Icon(Icons.folder_open),
              label: const Text("CHOOSE IMAGE"),
            )
          ],),
      ),
    );
  }
}