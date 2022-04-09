part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class IncrementEvent extends CartEvent {
  final Dish dish;

  IncrementEvent(this.dish);
}

class CartChangedEvent extends CartEvent {}

class DecrementEvent extends CartEvent {
  final Dish dish;

  DecrementEvent(this.dish);
}

class AddOrIncrementEvent extends CartEvent {
  final Dish dish;

  AddOrIncrementEvent(this.dish);
}

class RemoveEvent extends CartEvent {
  final Dish dish;

  RemoveEvent(this.dish);
}

class ClearEvent extends CartEvent {}
