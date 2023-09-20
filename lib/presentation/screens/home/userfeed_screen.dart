import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/logic/cubit/products_cubit/products_cubit.dart';
import 'package:ecom_app/logic/cubit/products_cubit/products_state.dart';
import 'package:ecom_app/presentation/screens/products/products_details_screen.dart';
import 'package:ecom_app/presentation/widgets/gap_space.dart';
import 'package:ecom_app/presentation/widgets/product_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui.dart';
import '../../../logic/services/formatter.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoadingState && state.products.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.green),
        );
      }
      if (state is ProductErrorState && state.products.isEmpty) {
        return Center(child: Text(state.message));
      }
     return ProductListView(products: state.products);
    }
    );
  }
}
