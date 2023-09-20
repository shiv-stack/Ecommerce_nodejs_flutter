import 'dart:async';

import 'package:ecom_app/data/models/cart/cart_item_model.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecom_app/data/repositories/cart_repositories.dart';
import 'package:ecom_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecom_app/logic/cubit/user_cubit/user_cubit.dart';

import '../../../data/models/products/products_model.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;
  CartCubit(this._userCubit) : super(CartInitialState()) {
    // initial Value
    _handleUSerState(_userCubit.state);
    // Listening to User Cubit(for future update)

    _userSubscription = _userCubit.stream.listen(_handleUSerState);
  }
  void _handleUSerState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(CartInitialState());
    }
  }

  void sortAndLoad(List<CartItemModel> items) {
    items.sort((a, b) => a.product!.title!.compareTo(b.product!.title!));
    emit(CartLoadedState(items));
  }

  final _cartRepository = CartRepository();
  void _initialize(String userId) async {
    try {
      emit(CartLoadingState(state.items));
      final items = await _cartRepository.FetchCartForUser(userId);
      sortAndLoad(items);
 
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void addToCart(ProductModel product, int quantity) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;
        CartItemModel newItem = CartItemModel(
          product: product,
          quantity: quantity,
        );
        final items =
            await _cartRepository.addToCart(newItem, userState.userModel.sId!);
        sortAndLoad(items);
      } else {
        throw "An error encountered";
      }
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  void removeCart(ProductModel product) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        final items = await _cartRepository.RemoveFromCart(
            product.sId!, userState.userModel.sId!);
      sortAndLoad(items);
      } else {
        throw "An error occured while deleting item";
      }
    } catch (ex) {
      emit(CartErrorState(ex.toString(), state.items));
    }
  }

  bool cartContains(ProductModel product) {
    if (state.items.isNotEmpty) {
      final foundItem = state.items
          .where((item) => item.product!.sId! == product.sId!)
          .toList();
      if (foundItem.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
