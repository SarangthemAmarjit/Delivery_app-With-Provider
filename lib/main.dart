import 'package:badges/badges.dart';
import 'package:deliveryapp/cart_provider.dart';
import 'package:deliveryapp/cart_screen.dart';
import 'package:deliveryapp/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home(),
        );
      }),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> itm = [
    ProductlistScreen(),
    Text('SEARCH'),
    Text('NOTIFICATION'),
    CartScreen(),
    const Text('ACCOUNT'),
  ];
  int currentselectedindex = 0;

  void _ontap(int index) {
    setState(() {
      currentselectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_outlined,
              ),
              label: 'Notification'),
          BottomNavigationBarItem(
              icon: Center(
                child: Badge(
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(value.getCounter().toString(),
                          style: TextStyle(color: Colors.white));
                    },
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  child: Icon(Icons.shopping_bag_outlined),
                ),
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_outlined,
              ),
              label: 'Account'),
        ],
        iconSize: 30,
        currentIndex: currentselectedindex,
        elevation: 5,
        selectedFontSize: 17,
        selectedItemColor: Colors.amber,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(color: Colors.amber),
        unselectedIconTheme: IconThemeData(color: Colors.black45),
        onTap: _ontap,
      ),
      body: itm.elementAt(currentselectedindex),
    );
  }
}
