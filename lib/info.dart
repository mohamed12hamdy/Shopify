import 'package:flutter/material.dart';

class info extends StatelessWidget {
  @override
  final String title;
  final String image;
  final int Id;
  final double rating;
  final int price;
  final double discount;
  info(this.title, this.image, this.Id, this.rating, this.price, this.discount);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //0xffF02E65
        title: Text('Product info'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.network(
                  this.image,
                  fit: BoxFit.fill,
                ),
                width: double.infinity,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      this.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Ratingbar(
                      rate: this.rating,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'You can have Discount Up to ${discount}',
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Ratingbar extends StatelessWidget {
  final double rate;
  final double size;
  int? ratingcount;
  Ratingbar({required this.rate, this.size = 18});

  @override
  Widget build(BuildContext context) {
    List<Widget> _startlist = [];
    int realnumber = rate.floor();
    int PartNumber = ((rate - realnumber) * 10).ceil();
    for (int i = 0; i < 5; i++) {
      if (i < realnumber) {
        _startlist.add(Icon(
          Icons.star,
          color: Theme.of(context).primaryColor,
          size: size,
        ));
      } else if (i == realnumber) {
        _startlist.add(SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                  size: size,
                ),
                ClipRect(
                  clipper: _Clipper(part: PartNumber),
                  child: Icon(Icons.star, color: Colors.grey, size: size),
                ),
              ],
            )));
      } else {
        _startlist.add(Icon(
          Icons.star,
          color: Colors.grey,
          size: size,
        ));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _startlist,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;
  _Clipper({required this.part});
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
        (size.width / 10) * part, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
