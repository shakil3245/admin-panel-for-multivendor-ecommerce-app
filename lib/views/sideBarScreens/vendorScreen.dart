import 'package:flutter/material.dart';

import '../widgets/vendorWidgets.dart';

class VendorScreen extends StatefulWidget {
  static const String routeName = '\Vendor';

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  Widget _rowHeader(String text,int flex ) {
    return Expanded(
      flex: flex,
        child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700),
          color: Colors.yellow.shade900),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Manage Vendor',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
          ),
          
          Row(children: [
            _rowHeader("LOGO", 1),
            _rowHeader("BUSINESS NAME", 3),
            _rowHeader("CITY", 2),
            _rowHeader("ACTION", 1),
            _rowHeader("VIEW MORE", 1),
          ],),
           VendorWidget(),
        ],
      ),
    );
  }
}
