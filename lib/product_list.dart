import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:deliveryapp/cart_model.dart';
import 'package:deliveryapp/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapp/db_helper.dart';
import 'package:deliveryapp/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductlistScreen extends StatefulWidget {
  const ProductlistScreen({Key? key}) : super(key: key);

  @override
  State<ProductlistScreen> createState() => _ProductlistScreenState();
}

class _ProductlistScreenState extends State<ProductlistScreen> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = [
    'Briyani',
    'Chikken Grilled',
    'Chikken Chilli',
    'Chikken Chow',
    'Fried Rice',
    'Chikken Momo',
    'Samosa',
    'Bugger'
  ];
  List<String> productUnit = [
    'Bowl',
    'Full',
    'Bowl',
    'Plate',
    'Plate',
    'Plate',
    'Piece',
    'Piece',
  ];
  List<int> productPrice = [250, 800, 250, 110, 120, 130, 20, 40];
  List<String> productImage = [
    'images/briyani.jpg',
    'images/chikken_grill.png',
    'images/chikken_chilli.jpg',
    'images/chou.png',
    'images/fried_rice.png',
    'images/momo.webp',
    'images/samosa.png',
    'images/bugger.png'
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color.fromARGB(255, 247, 239, 152),
              Color.fromARGB(255, 159, 250, 227)
            ])),
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Image.asset('images/new3.jpg'),
                Image.asset('images/4ok.jpg'),
                Image.asset('images/new1.jpg'),
                Image.asset('images/new2.jpg'),
                Image.asset('images/new44.jpg'),
                Image.asset('images/new55.jpg'),
              ],
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.70,
                  height: 200,
                  onPageChanged: (i, r) {
                    setState(() {
                      _current = i;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AnimatedSmoothIndicator(
                activeIndex: _current,
                count: 6,
                effect: const WormEffect(
                    spacing: 8.0,
                    radius: 2.0,
                    dotWidth: 7.0,
                    dotHeight: 7.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    activeDotColor: Colors.pinkAccent),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 7,
                        childAspectRatio: 3 / 4.5),
                    itemCount: productName.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    alignment: Alignment.center,
                                    height: 120,
                                    width: 120,
                                    image: AssetImage(
                                        productImage[index].toString())),
                                Text(
                                  productName[index].toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\₹',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      productPrice[index].toString() +
                                          '/' +
                                          productUnit[index].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    onPressed: () {
                                      print(index);
                                      print(index);
                                      print(productName[index].toString());
                                      print(productPrice[index].toString());
                                      print(productPrice[index]);
                                      print('1');
                                      print(productUnit[index].toString());
                                      print(productImage[index].toString());

                                      dbHelper!
                                          .insert(Cart(
                                              id: index,
                                              productId: index.toString(),
                                              productName:
                                                  productName[index].toString(),
                                              initialPrice: productPrice[index],
                                              productPrice: productPrice[index],
                                              quantity: 1,
                                              unitTag:
                                                  productUnit[index].toString(),
                                              image: productImage[index]
                                                  .toString()))
                                          .then((value) {
                                        cart.addTotalPrice(double.parse(
                                            productPrice[index].toString()));
                                        cart.addCounter();

                                        final snackBar = SnackBar(
                                          backgroundColor: Colors.green,
                                          content:
                                              Text('Product is added to cart'),
                                          duration: Duration(seconds: 1),
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }).onError((error, stackTrace) {
                                        print("error" + error.toString());
                                        final snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                'Product is already added in cart'),
                                            duration: Duration(seconds: 1));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    },
                                    child: Text('Add To Cart'))
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
