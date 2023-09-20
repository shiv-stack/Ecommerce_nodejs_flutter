import 'package:ecom_app/data/models/category/category_model.dart';
import 'package:ecom_app/data/repositories/product_repositories.dart';
import 'package:ecom_app/logic/cubit/category_cubit/category_state.dart';
import 'package:ecom_app/logic/cubit/category_product_cubit/category_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }
  final _productRepository = ProductRepository();

  void _initialize() async{
    emit(CategoryProductLoadingState(state.products));
    try {
      final products = await _productRepository.FetchProductsByCategory(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(CategoryProductErrorState(ex.toString(), state.products));
    }
  }
}
