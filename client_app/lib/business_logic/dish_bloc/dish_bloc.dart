import 'package:client_app/classes/dish.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'dish_event.dart';
part 'dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  final FirebaseFirestore firebaseFirestore;
  DishBloc(this.firebaseFirestore) : super(DishInitial()) {
    on<FetchEvent>(_onFetch);
  }
  Future<void> _onFetch(FetchEvent event, Emitter emit) async {
    emit(FetchLoadingState());
    var rawDishes = await firebaseFirestore.collection('dishes').get();
    List<Dish> dishes = [];
    rawDishes.docs.forEach((snap){
      final dish = Dish.fromJson(snap.data(), snap.id);
      dishes.add(dish);
    });
    emit(FetchState(dishes));
  }
}
