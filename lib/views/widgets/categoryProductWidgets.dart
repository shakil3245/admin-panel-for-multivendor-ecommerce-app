import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryProductWidget extends StatefulWidget {
  const CategoryProductWidget({Key? key}) : super(key: key);

  @override
  State<CategoryProductWidget> createState() => _CategoryProductWidgetState();
}

class _CategoryProductWidgetState extends State<CategoryProductWidget> {
  final Stream<QuerySnapshot> _categoryStream =
      FirebaseFirestore.instance.collection('Categories').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _categoryStream,
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
                Text("CategoryName"),
              ],);
            });
      },
    );
  }
}
