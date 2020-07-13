import 'package:dan_flutter_app/models/product.dart';
import 'package:dan_flutter_app/ui/Favorite/favorite_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailCell extends StatefulWidget {
  ProductDetailCell(this.product);

  final Product product;

  @override
  _ProductDetailCellState createState() => _ProductDetailCellState();
}

class _ProductDetailCellState extends State<ProductDetailCell> {
  @override
  Widget build(BuildContext context) {
    var pricenow = (widget.product.price * widget.product.sale_precent / 100 -
            widget.product.price) *
        -1;
    var pricethen = widget.product.price / 1;

    return Container(
      child: ListView(
        //Column(
        children: <Widget>[
          Container(
            child: Image.network(widget.product.image),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(00, 5, 00, 5),
            child: Text(
              widget.product.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepPurple[900],
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(00, 5, 00, 5),
            child: Text(
              widget.product.short_description,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(00, 5, 00, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    '$pricenow',
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w900,
                        fontSize: 25),
                  ),
                ),
                Container(
                  child: Text(
                    widget.product.sale_precent > 0 ? '$pricethen' : "",
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Icon(Icons.check_circle_outline),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\tInformation!!!',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Text(
              widget.product.details,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            child: Icon(
              Icons.favorite_border,
              size: 30,
              color: widget.product.favourite ? Colors.red : Colors.black,
            ),
            onTap: () {
              if (widget.product.favourite) {
                FavoriteDataBaseSingleton().removeFromFavourite(widget.product);
              } else {
                FavoriteDataBaseSingleton().addToFavourite(widget.product);
              }
            },
          ),
        ],
        // ),
      ),
    );
  }
}
