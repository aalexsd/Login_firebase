import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../collection/data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestrictedDisplayWidget extends StatefulWidget {
  const RestrictedDisplayWidget({Key? key}) : super(key: key);

  @override
  State<RestrictedDisplayWidget> createState() =>
      _RestrictedDisplayWidgetState();
}

class _RestrictedDisplayWidgetState extends State<RestrictedDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Icon(
                Icons.local_fire_department,
                color: Colors.deepOrange,
              ),
              SizedBox(width: 8),
              Text(
                'Parabéns, você desbloqueou as \nelhores ofertas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        Expanded(
          //gridview to display products
          child: MasonryGridView.count(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            crossAxisSpacing: 10,
            crossAxisCount: 1,
            itemCount: products.length,
            mainAxisSpacing: 20,
            itemBuilder: (context, index) {
              return singleItemWidget(
                products[index], index == products.length - 1 ? true : false,
              );
            },
          ),
        ),
      ],
    );
  }


  // single item widget

  Widget singleItemWidget(Product product, bool lastItem) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(1, 1),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: CachedNetworkImage(
                        width: 300,
                        height: 300,
                        imageUrl: product.productImageUrl,
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      product.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Row(
                      children: [
                        Text('R\$${product.currentPrice}'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'R\$${product.oldPrice}',
                          style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 15,
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                    product.isLiked == true
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    size: 15,
                    color: Colors.white),
              ),
            )
          ],
        ),
        SizedBox(
          height:
              lastItem == true ? MediaQuery.of(context).size.height * 0.40 : 0,
        )
      ],
    );
  }
}
