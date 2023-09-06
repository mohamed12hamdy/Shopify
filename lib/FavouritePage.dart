import 'package:flutter/material.dart';
import 'package:shopify/products.dart';
import 'sqflite.dart';

class Favourite extends StatefulWidget {
  Favourite({super.key});

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  Sqflite mydb = Sqflite();
  List<products> favList = [];
  bool isLoading = true;

  myReadData() async {
    List<Map> response = await mydb.myRead('fav');
    favList = response.map((item) => products (
        title: item['title'],
        Image: item['Image'],
        Id: item['id'],
        // price: item["price"],
        // discount: item["discountPercentage"],
    )).toList();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    myReadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (favList.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Text(
            "You don't have any favourites",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) =>
                    buildproductmodel(favList[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15.0,
                ),
                itemCount: favList.length,
              ),
      ),
    );
  }

  Widget buildproductmodel(products fav) {
    return Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.only(bottom: 8),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          Expanded(
            child: Column(children: [
              Image.network(
                fav.Image,
                fit: BoxFit.fitWidth,
              ),
              Text(
                fav.title
              ),
            ]),
          ),
          PressedIconButton(fav)
        ])
    );
  }
}
