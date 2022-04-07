part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartChangedState extends CartState {
  final int totalSum;

  CartChangedState(this.totalSum);
}
