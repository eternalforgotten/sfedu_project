import 'package:bloc/bloc.dart';
import 'package:client_app/classes/dish.dart';
import 'package:client_app/repos/repo.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cart;
  CartBloc(this.cart) : super(CartInitial()) {
    on<DecrementEvent>(_onDecrement);
    on<AddOrIncrementEvent>(_onAdd);
    on<RemoveEvent>(_onRemove);
    on<ClearEvent>(_onClear);
  }

  void _onDecrement(DecrementEvent event, Emitter emit){
    if (event.dish.quantity > 1){
      cart.decrement(event.dish.id);
    }
    else {
      cart.remove(event.dish.id);
    }
    emit(CartChangedState(recalculate()));
  }
  void _onRemove(RemoveEvent event, Emitter emit){
    cart.remove(event.dish.id);
    emit(CartChangedState(recalculate()));
  }
  void _onAdd(AddOrIncrementEvent event, Emitter emit){
    cart.add(event.dish);
    emit(CartChangedState(recalculate()));
  }

  void _onClear(ClearEvent event, Emitter emit){
    cart.clear();
    emit(CartChangedState(recalculate()));
  }

  int recalculate(){
    int sum = 0;
    cart.cart.forEach((dish) {
      sum += dish.quantity * int.parse(dish.price);
    });
    return sum;
  }
}
