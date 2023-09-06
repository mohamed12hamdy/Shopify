import 'package:flutter/material.dart';
import 'package:shopify/ApiConstants.dart';
import 'package:shopify/DioHelper.dart';
import 'package:shopify/Login.dart';
import 'package:shopify/data_provider/remote/firebaseHelper.dart';
import 'package:shopify/info.dart';
import 'package:shopify/products.dart';
import 'package:shopify/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<products> product = [];

  Future<List> getData() async {
    List myproducts = await DioHelper()
        .getProducts(path: ApiConstants.baseUrl + ApiConstants.EndPoint);
    product = products.ConvertToProducts(myproducts);
    return product;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/shop.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text("Shopify",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () async {
                  Sqflite mydb = Sqflite();
                  await FireBaseHelper().SignOut();
                  mydb.deleteTable('fav');
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()));
                },
                icon: Icon(Icons.logout))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getData(),
            builder: (context, Snapshot) {
              if (Snapshot.hasError)
                return Center(child: Text('ERROR'));
              else if (Snapshot.hasData)
                return ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.only(bottom: 8),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Image.network(
                              product[index].Image,
                              fit: BoxFit.fitWidth,
                            ),
                            onTap: () {
                              //title, image, Id, rating, price, discount
                              final String title = product[index].title;
                              final String image = product[index].Image;
                              final int Id = product[index].Id;
                              // final double rating = product[index].rating;
                              // final int price = product[index].price;
                              // final double discount = product[index].discount;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          info(title, image, Id, 3, 20, 2.3)));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            product[index].title,
                          ),
                          PressedIconButton(product[index])
                        ],
                      ),
                    );
                  },
                );
              else
                return Center(child: CircularProgressIndicator());
            }),
      ),

      /*ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.only(bottom: 8),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        product[index].Image,
                        fit: BoxFit.fitWidth,
                      ),
                      Text(
                        product[index].title,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
            ),*/
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  var main_products = <products>[];

  Future<List> getData() async {
    List myproducts = await DioHelper()
        .getProducts(path: ApiConstants.baseUrl + ApiConstants.EndPoint);
    main_products = products.ConvertToProducts(myproducts);
    return main_products;
    //setState(() {});
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return (IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      // List<products> display_products = List.from(main_products);
      // display_products =main_products.where((element) => element.title!.toLowerCase().contains(query.toLowerCase()),).toList();
      List<products> filteredNames = main_products.where((products) => products.title.toLowerCase().contains(query)).toList();
    return Scaffold(
       body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getData(),
            builder: (context, Snapshot) {
              if (Snapshot.hasError)
                return Center(child: Text('ERROR'));
              else if (Snapshot.hasData)
                return ListView.builder(
                  itemCount: filteredNames.length,
                  itemBuilder: (context, index) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.only(bottom: 8),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Image.network(
                              filteredNames[index].Image,
                              fit: BoxFit.fitWidth,
                            ),
                            onTap: () {
                              //title, image, Id, rating, price, discount
                              final String title = filteredNames[index].title;
                              final String image = filteredNames[index].Image;
                              final int Id = filteredNames[index].Id;
                              // final double rating = product[index].rating;
                              // final int price = product[index].price;
                              // final double discount = product[index].discount;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          info(title, image, Id, 3, 20, 2.3)));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            filteredNames[index].title,
                          ),
                          PressedIconButton(filteredNames[index])
                        ],
                      ),
                    );
                  },
                );
              else
                return Center(child: CircularProgressIndicator());
            }),
      ),

        );
  }

  @override
  Widget buildResults(BuildContext context) {
      List<products> filteredNames = main_products.where((products) => products.title.toLowerCase().contains(query)).toList();
     return Scaffold(
       body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getData(),
            builder: (context, Snapshot) {
              if (Snapshot.hasError)
                return Center(child: Text('ERROR'));
              else if (Snapshot.hasData)
                return ListView.builder(
                  itemCount: filteredNames.length,
                  itemBuilder: (context, index) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.only(bottom: 8),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Image.network(
                              filteredNames[index].Image,
                              fit: BoxFit.fitWidth,
                            ),
                            onTap: () {
                              //title, image, Id, rating, price, discount
                              final String title = filteredNames[index].title;
                              final String image = filteredNames[index].Image;
                              final int Id = filteredNames[index].Id;
                              // final double rating = product[index].rating;
                              // final int price = product[index].price;
                              // final double discount = product[index].discount;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          info(title, image, Id, 3, 20, 2.3)));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            filteredNames[index].title,
                          ),
                          PressedIconButton(filteredNames[index])
                        ],
                      ),
                    );
                  },
                );
              else
                return Center(child: CircularProgressIndicator());
            }),
      ),

        );
        }
}
