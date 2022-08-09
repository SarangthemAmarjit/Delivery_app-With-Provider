import 'package:badges/badges.dart';

import 'package:deliveryapp/db_helper.dart';
import 'package:deliveryapp/cart_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        centerTitle: true,
        actions: [
          Center(
            child: Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(value.getCounter().toString(),
                      style: TextStyle(color: Colors.white));
                },
              ),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(width: 20.0)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color.fromARGB(255, 159, 250, 227),
              Color.fromARGB(255, 247, 239, 152)
            ])),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: cart.getData(),
                  builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Image(
                                    image: AssetImage('images/empty.png'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Explore products and shop your\nfavourite items',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image(
                                              height: 100,
                                              width: 100,
                                              image: AssetImage(snapshot
                                                  .data![index].image
                                                  .toString()),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            .productName
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            dbHelper!.delete(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!);
                                                            cart.removerCounter();
                                                            cart.removeTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .productPrice
                                                                    .toString()));
                                                          },
                                                          child: Icon(
                                                              Icons.delete))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    r"₹ " +
                                                        snapshot.data![index]
                                                            .initialPrice
                                                            .toString() +
                                                        '/' +
                                                        snapshot.data![index]
                                                            .unitTag
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              'Qnt :' +
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black45)),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text('Total Price :' +
                                                              "₹ " +
                                                              snapshot
                                                                  .data![index]
                                                                  .productPrice
                                                                  .toString()),
                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 35,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                InkWell(
                                                                    onTap: () {
                                                                      int quantity = snapshot
                                                                          .data![
                                                                              index]
                                                                          .quantity!;
                                                                      int price = snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice!;
                                                                      quantity--;
                                                                      int?
                                                                          newPrice =
                                                                          price *
                                                                              quantity;

                                                                      if (quantity >
                                                                          0) {
                                                                        dbHelper!
                                                                            .updateQuantity(Cart(
                                                                                id: snapshot.data![index].id!,
                                                                                productId: snapshot.data![index].id!.toString(),
                                                                                productName: snapshot.data![index].productName!,
                                                                                initialPrice: snapshot.data![index].initialPrice!,
                                                                                productPrice: newPrice,
                                                                                quantity: quantity,
                                                                                unitTag: snapshot.data![index].unitTag.toString(),
                                                                                image: snapshot.data![index].image.toString()))
                                                                            .then((value) {
                                                                          newPrice =
                                                                              0;
                                                                          quantity =
                                                                              0;
                                                                          cart.removeTotalPrice(double.parse(snapshot
                                                                              .data![index]
                                                                              .initialPrice!
                                                                              .toString()));
                                                                        }).onError((error, stackTrace) {
                                                                          print(
                                                                              error.toString());
                                                                        });
                                                                      }
                                                                    },
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                                Text(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                                InkWell(
                                                                    onTap: () {
                                                                      int quantity = snapshot
                                                                          .data![
                                                                              index]
                                                                          .quantity!;
                                                                      int price = snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice!;
                                                                      quantity++;
                                                                      int?
                                                                          newPrice =
                                                                          price *
                                                                              quantity;

                                                                      dbHelper!
                                                                          .updateQuantity(Cart(
                                                                              id: snapshot.data![index].id!,
                                                                              productId: snapshot.data![index].id!.toString(),
                                                                              productName: snapshot.data![index].productName!,
                                                                              initialPrice: snapshot.data![index].initialPrice!,
                                                                              productPrice: newPrice,
                                                                              quantity: quantity,
                                                                              unitTag: snapshot.data![index].unitTag.toString(),
                                                                              image: snapshot.data![index].image.toString()))
                                                                          .then((value) {
                                                                        newPrice =
                                                                            0;
                                                                        quantity =
                                                                            0;
                                                                        cart.addTotalPrice(double.parse(snapshot
                                                                            .data![index]
                                                                            .initialPrice!
                                                                            .toString()));
                                                                      }).onError((error, stackTrace) {
                                                                        print(error
                                                                            .toString());
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    }
                    return Text('');
                  }),
              Consumer<CartProvider>(builder: (context, value, child) {
                double subtotal = value.getTotalPrice();
                double discount = subtotal * 0.2;
                double total = subtotal - discount;
                return Visibility(
                  visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                      ? false
                      : true,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReusableWidget(
                          title: 'Sub Total :',
                          value: r'₹' + subtotal.toStringAsFixed(2),
                        ),
                        ReusableWidget(
                          title: 'Discout 5%',
                          value: r'₹' + discount.toStringAsFixed(2),
                        ),
                        ReusableWidget(
                          title: 'Total :',
                          value: r'₹' + total.toStringAsFixed(2),
                        )
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(value.toString(), style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
