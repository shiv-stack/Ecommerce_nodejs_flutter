import 'package:ecom_app/data/repositories/product_repositories.dart';
import 'package:ecom_app/logic/cubit/products_cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }
  final _productRepository = ProductRepository();
  void _initialize() async{
    emit(ProductLoadingState(state.products));
    try {
      final products = await _productRepository.FetchAllProducts();
      emit(ProductLoadedState(products));

    } catch (ex) {
      emit(ProductErrorState(ex.toString(), state.products));
    }
  }
}
