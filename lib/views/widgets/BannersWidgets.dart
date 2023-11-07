import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannersWidgets extends StatefulWidget {
  const BannersWidgets({Key? key}) : super(key: key);

  @override
  State<BannersWidgets> createState() => _BannersWidgetsState();
}

class _BannersWidgetsState extends State<BannersWidgets> {
  final Stream<QuerySnapshot> _bannerStream =
  FirebaseFirestore.instance.collection('Bannners').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bannerStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6,mainAxisSpacing: 8,crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              final categoryData = snapshot.data!.docs[index];
              return Column(children: [
                SizedBox(height: 100,width: 100,child: Image.network(categoryData['image']),),
              ],);
            });
      },
    );
  }
}
