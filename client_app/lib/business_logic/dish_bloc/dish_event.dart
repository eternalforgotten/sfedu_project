part of 'dish_bloc.dart';

@immutable
abstract class DishEvent {}

class FetchEvent extends DishEvent{}

class ChangedCategoryEvent extends DishEvent {
  final DishCategoryName categoryName;

  ChangedCategoryEvent(this.categoryName);
}
