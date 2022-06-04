import 'dart:async';
import 'package:client_app/classes/dish.dart';
import 'package:client_app/classes/dish_category.dart';
import 'package:client_app/main.dart';
import 'package:client_app/repos/fb_storage.dart';
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
    try {
      var rawDishes = await firebaseFirestore.collection('dishes').get();
      for (var i = 0; i < rawDishes.docs.length; i++) {
        var item = rawDishes.docs[i];
        var data = item.data();
        var url = await FileStorage.downloadPath(item.id);
        data.addAll({
          'image_url': url,
        });
        final dish = Dish.fromJson(data, item.id);
        _dishes.add(dish);
      }
      if (_selectedCategory == DishCategoryName.all) {
        emit(FetchState(_dishes));
        return;
      }
      final dishes = _dishes
          .where((element) => element.category == _selectedCategory)
          .toList();

      emit(FetchState(dishes));
    } catch (e) {
      emit(ErrorState('Произошла ошибка при загрузке блюд'));
    }
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
