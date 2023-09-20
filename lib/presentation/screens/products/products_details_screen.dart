import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/core/ui.dart';
import 'package:ecom_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecom_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecom_app/logic/services/formatter.dart';
import 'package:ecom_app/presentation/widgets/gap_space.dart';
import 'package:ecom_app/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:ecom_app/data/models/products/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);
  static const routeName = "product_details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
                slideBuilder: (index) {
                  String url = widget.productModel.images![index];

                  return CachedNetworkImage(imageUrl: url);
                },
                itemCount: widget.productModel.images?.length ?? 0),
          ),
          const SizedBoxSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.productModel.title}",
                  style: TextStyles.h3,
                ),
                Text(
                  Formatter.formatPrice(widget.productModel.price!),
                  style: TextStyles.h2,
                ),
                const SizedBoxSpace(),
                BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                  bool isInCart = (BlocProvider.of<CartCubit>(context)
                      .cartContains(widget.productModel));
                  return PrimaryButton(
                      onPressed: () {
                        log("add to cart pressed");
                        if (isInCart) {
                          return;
                        }
                        BlocProvider.of<CartCubit>(context)
                            .addToCart(widget.productModel, 1);
                      },
                      color:
                          (isInCart) ? AppColors.textLight : AppColors.accent,
                      text:
                          (isInCart) ? "Already added to cart" : "Add to Cart");
                }),
                const SizedBoxSpace(),
                Text(
                  "Description",
                  style: TextStyles.b2.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.productModel.description}",
                  style: TextStyles.b1,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
