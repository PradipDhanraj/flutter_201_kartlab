// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_201_kartlab/src/modules/home/service/models/product_model.dart';

class ProductCardWidget extends StatefulWidget {
  Products e;
  bool isSelected;
  bool showWishIcon;
  Function()? addToWishlistFunc;
  ProductCardWidget(
    this.e, {
    super.key,
    this.isSelected = false,
    this.showWishIcon = false,
    this.addToWishlistFunc,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          // border: Border.all(
          //   color: Colors.red,
          //   width: 2.0,
          // ),
          color: widget.isSelected ? Colors.green : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.e.productName,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.e.productPrice,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    widget.e.productDescription,
                    softWrap: true,
                    maxLines: 4,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.showWishIcon) const Spacer(),
                  if (widget.showWishIcon)
                    InkWell(
                      onTap: widget.addToWishlistFunc,
                      child: Chip(
                        label: widget.e.isInMyWishList ? Text("Wished") : Text("Add to Wishlist"),
                        avatar: Icon(
                          widget.e.isInMyWishList ? Icons.favorite : Icons.favorite_border,
                          color: widget.e.isInMyWishList ? Colors.red : Colors.white,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Image.network(widget.e.productThumnailUrl),
            ),
          ],
        ),
      ),
    );
  }
}
