import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_vendor_admin_web/views/sideBarScreens/DashboardScrenn.dart';
import 'package:multi_vendor_admin_web/views/sideBarScreens/categoryScreen.dart';
import 'package:multi_vendor_admin_web/views/sideBarScreens/orderScreen.dart';
import 'package:multi_vendor_admin_web/views/sideBarScreens/productScreen.dart';
import 'package:multi_vendor_admin_web/views/sideBarScreens/uploadBannerScreen.dart';
import 'package:multi_vendor_admin_web/views/sideBarScreens/vendorScreen.dart';
import 'package:multi_vendor_admin_web/views/sideBarScreens/withdrawalScreen.dart';

class AdminPage extends StatefulWidget {


  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Widget _selectedItem = DashboardScreen();

  screenSelector(item){
    switch(item.route){
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;
      case VendorScreen.routeName:
        setState(() {
          _selectedItem = VendorScreen();
        });
        break;
      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem = WithdrawalScreen();
        });
        break;
      case OrderScreen.routeName:
        setState(() {
          _selectedItem = OrderScreen();
        });
        break;
      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });
        break;
      case ProductScreen.routeName:
        setState(() {
          _selectedItem = ProductScreen();
        });
        break;
      case UploadScreen.routeName:
        setState(() {
          _selectedItem = UploadScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('D-Shop'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashboardScreen.routeName,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Vendors',
            route: VendorScreen.routeName,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            route: WithdrawalScreen.routeName,
            icon: CupertinoIcons.money_dollar,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreen.routeName,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoriesScreen.routeName,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Product',
            route: ProductScreen.routeName,
            icon: Icons.shop,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            route: UploadScreen.routeName,
            icon: Icons.add,
          ),

        ],
        selectedRoute: '/',
        onSelected: (item) {
         screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedItem
    );
  }
}
