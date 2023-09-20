import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/core/ui.dart';
import 'package:ecom_app/core/url.dart';
import 'package:ecom_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecom_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecom_app/presentation/screens/home/home_screen.dart';
import 'package:ecom_app/presentation/widgets/gap_space.dart';
import 'package:ecom_app/presentation/widgets/link_button.dart';
import 'package:ecom_app/presentation/widgets/primary_button.dart';
import 'package:ecom_app/presentation/widgets/quantity_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/services/calculations.dart';
import '../../../logic/services/formatter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const String routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Your Cart"),
      ),
      body: SafeArea(
          child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        if (state is CartLoadingState && state.items.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CartErrorState && state.items.isEmpty) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is CartLoadedState && state.items.isEmpty) {
          return Center(
            child: Column(
              children: [
                Container(
                    child: CachedNetworkImage(
                  imageUrl: Appimages.cartempty,
                )),
                Container(
                  child: const Text("Your Cart is  Empty"),
                ),
                SizedBoxSpace(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                  child: PrimaryButton(
                    text: "Shop now",
                    onPressed: () {
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    },
                  ),
                )
              ],
            ),
          );
        }
        return Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    leading:
                        CachedNetworkImage(imageUrl: item.product!.images![0]),
                    title: Text("${item.product?.title}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${Formatter.formatPrice(item.product!.price!)} x ${item.quantity} = ${Formatter.formatPrice(item.product!.price! * item.quantity!)}"),
                        LinkButton(
                            color: Colors.red,
                            onPressed: () {
                              BlocProvider.of<CartCubit>(context)
                                  .removeCart(item.product!);
                            },
                            text: "Remove")
                      ],
                    ),
                    trailing: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 3,
                      child: QuantityInputWidget(
                        initialValue: item.quantity!,
                        onChanged: (value) {
                          BlocProvider.of<CartCubit>(context)
                              .addToCart(item.product!, value as int);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${state.items.length} items",
                        style:
                            TextStyles.b1.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Total :${Formatter.formatPrice(Calculations.cartTotal(state.items))}",
                        style: TextStyles.h3,
                      ),
                    ],
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: CupertinoButton(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 22),
                        color: AppColors.accent,
                        child: const Text("Place Order"),
                        onPressed: () {}),
                  )
                ],
              ),
            )
          ],
        );
      })),
    );
  }
}
