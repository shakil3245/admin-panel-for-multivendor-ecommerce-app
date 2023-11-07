import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VendorWidget extends StatefulWidget {
   VendorWidget({Key? key}) : super(key: key);

  @override
  State<VendorWidget> createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  Widget vendorData(int? flex, Widget widget) {
    return Expanded(
        flex: flex!,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: widget,
        ));
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _vendorDataStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _vendorDataStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              //STORE ALL DATA TO THIS VARIABLE
              final vendorUserData = snapshot.data!.docs[index];
              return Row(
                children: [
                  vendorData(
                      1,
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Image.network(vendorUserData['storeImage']),
                      )),
                  vendorData(
                      3,
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(vendorUserData['bussinessName']),
                      ))),
                  vendorData(
                      2,
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(vendorUserData['location']),
                      ))),
                  vendorUserData['approved'] == false
                      ? ElevatedButton(
                          onPressed: () {
                            //UPDATEING THE VENDOR APPROVED BOOL RESULT
                            _firestore.collection('vendors').doc(vendorUserData['Uid']).update({
                              'approved': true,
                            });
                          }, child: const Text("Approved",style: TextStyle(color: Colors.green)))
                      : vendorData(
                          1,
                          ElevatedButton(
                              onPressed: () {
                                _firestore.collection('vendors').doc(vendorUserData['Uid']).update({
                                  'approved': false,
                                });
                              }, child: const Text("Reject",style: TextStyle(color: Colors.red),))),
                  vendorData(
                      1,
                      ElevatedButton(
                          onPressed: () {}, child: const Text("View More",))),
                ],
              );
            });
      },
    );
  }
}
