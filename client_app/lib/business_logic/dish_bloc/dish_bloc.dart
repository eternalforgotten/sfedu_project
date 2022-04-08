import 'package:client_app/classes/dish.dart';
import 'package:client_app/classes/dish_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'dish_event.dart';
part 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  DishCategoryName _selectedCategory = DishCategoryName.all;
  final FirebaseFirestore firebaseFirestore;
  List<Dish> _dishes = [];
  DishBloc(this.firebaseFirestore) : super(DishInitial()) {
    on<FetchEvent>(_onFetch);
    on<ChangedCategoryEvent>(_onCategoryChanged);
  }
  Future<void> _onFetch(FetchEvent event, Emitter emit) async {
    _dishes.clear();
    emit(FetchLoadingState());
    var rawDishes = await firebaseFirestore.collection('dishes').get();
    rawDishes.docs.forEach((snap) {
      final dish = Dish.fromJson(snap.data(), snap.id);
      _dishes.add(dish);
    });
    if (_selectedCategory == DishCategoryName.all) {
      emit(FetchState(_dishes));
      return;
    }
    final dishes =
        _dishes.where((element) => element.category == _selectedCategory).toList();
    emit(FetchState(dishes));
  }

  void _onCategoryChanged(ChangedCategoryEvent event, Emitter emit) {
    _selectedCategory = event.categoryName;
    if (_selectedCategory == DishCategoryName.all) {
      emit(FetchState(_dishes));
      return;
    }

    final dishes =
        _dishes.where((element) => element.category == _selectedCategory);
    emit(FetchState(dishes.toList()));
  }
}
