import 'package:ecom_app/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecom_app/logic/cubit/category_product_cubit/category_product_state.dart';
import 'package:ecom_app/presentation/widgets/product_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class categoryProduct extends StatefulWidget {
  const categoryProduct({super.key});
  static const routeName = "category_product";

  @override
  State<categoryProduct> createState() => _categoryProductState();
}

class _categoryProductState extends State<categoryProduct> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoryProductCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${cubit.category.title}"),
      ),
      body: SafeArea(
          child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
        builder: (context, state) {
          if (state is CategoryProductLoadingState && state.products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryProductErrorState && state.products.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is CategoryProductLoadedState && state.products.isEmpty) {
            return const Center(
              child: Text("NO products found"),
            );
          }
          return ProductListView(products: state.products);
        },
      )),
    );
  }
}
