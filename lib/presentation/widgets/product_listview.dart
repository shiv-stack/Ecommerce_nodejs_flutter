import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/ui.dart';
import '../../data/models/products/products_model.dart';
import '../../logic/services/formatter.dart';
import '../screens/products/products_details_screen.dart';
import 'gap_space.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductListView({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return CupertinoButton(
            onPressed: () {
              Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                  arguments: product);
            },
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 3,
                  imageUrl: "${product.images?[0]}",
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.title}",
                        style:
                            TextStyles.b1.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text("${product.description}",
                          style: TextStyles.b2.copyWith(
                            color: AppColors.textLight,
                          )),
                      const SizedBoxSpace(),
                      Text(
                        Formatter.formatPrice(product.price!),
                        style: TextStyles.h3,
                      ),
                      const SizedBoxSpace(),
                       const Divider()
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
              ],
               
            ),
             
          );
         
        });
  }
}
