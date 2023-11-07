import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../widgets/BannersWidgets.dart';

class UploadScreen extends StatefulWidget {
  static const String routeName = '\Upload';

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

// Image Picking from computer
  dynamic _image;
  String? fileName;
  Future<void> _picFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  //upload banners to FirebaseStorage function and its return the url of the image file

   _uploadBannerToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('Banners').child(fileName!);
       UploadTask uploadTask = ref.putData(image);
       TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();
        return downloadURL;
  }

  //upload banner to FirebaseFireStore
  uploadToFirebaseFireStore() async {
    EasyLoading.show();
    if(_image != null){
      String ImageUrl = await _uploadBannerToStorage(_image);

      _firestore.collection('Bannners').doc(fileName).set(
        {
        'image':ImageUrl,
        }
      ).whenComplete((){
        EasyLoading.dismiss();
        setState(() {
          _image = null;
        });
      });
    }
  }

//validation Checking
//   uploadCategory(){
//     if(_globalKey.currentState!.validate()){
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("successfully Completed!")));
//     }else{
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not Completed!"),backgroundColor: Colors.red,));
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Banners',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15)),
                    child:_image != null? ClipRRect(child: Image.memory(_image,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(15),) :Center(child: Text("Banner"),),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {
                      uploadToFirebaseFireStore();
                    },
                    child: Text('Save')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    _picFile();
                  },
                  child: Text("Upload Image")),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Banners",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            BannersWidgets(),
          ],
        ),
      ),
    );
  }
}
