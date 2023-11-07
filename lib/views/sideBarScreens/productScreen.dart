import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {

  static const String routeName = '\Product';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {


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
              'Product',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(children: [
            _rowHeader("IMAGE", 1),
            _rowHeader("NAME", 3),
            _rowHeader("PRICE", 2),
            _rowHeader("QUANTITY", 2),
            _rowHeader("ACTION", 1),
            _rowHeader("VIEW MORE", 1),
          ],)
        ],
      ),
    );
  }
}
