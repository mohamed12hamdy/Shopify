import 'package:flutter/material.dart';
import 'sqflite.dart';

class products {
  final String title;
  final String Image;
  final int Id;
  // final double rating;
  // final int price;
  // final double discount;
  products({
    required this.title,
    required this.Image,
    required this.Id,
    // required this.rating,
    // required this.price,
    // required this.discount
  });

  static List<products> ConvertToProducts(List product) {
    List<products> productList = [];
    for (var counter in product) {
      if (counter["title"] == null || counter["images"][0] == null)
        continue;
      else {
        productList.add(products(
          title: counter["title"],
          Image: counter["images"][0],
          Id: counter["id"],
          // price: counter["price"],
          // discount: counter["discountPercentage"],
          // rating: counter["rating"],
        ));
      }
    }
    return productList;
  }
}

class PressedIconButton extends StatefulWidget {
  final products product;
  PressedIconButton(this.product) {}

  @override
  _PressedIconButtonState createState() => _PressedIconButtonState();
}

class _PressedIconButtonState extends State<PressedIconButton> {
  bool _isPressed = false;
  Sqflite mydb = Sqflite();

  void _onPressed(products product) {
    setState(() {
      _isPressed = true;
      mydb.myInsert('fav', {
        "title": product.title,
        "Image": product.Image,
        "id": product.Id,
        // "price":product.price,
        // "discountPercentage":product.discount
      });
      print('Icon Button Pressed!');
    });
  }

  void _onUnpressed(products product) {
    setState(() {
      _isPressed = false;
      mydb.myDelete('fav', "id=${product.Id}");
      print('Icon Button Unpressed!');
    });
  }

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  void checkFavoriteStatus() async {
    List<Map<String, dynamic>> response = await mydb.readData('''
    SELECT id 
    FROM 'fav'
     where id = ${widget.product.Id}
    ''');
    setState(() {
      _isPressed = response.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isPressed ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        if (_isPressed) {
          _onUnpressed(widget.product);
        } else {
          _onPressed(widget.product);
        }
      },
    );
  }
}
