import 'package:dicoding_final/features/search/domain/usecases/search_restaurant.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required SearchRestaurant usecase})
      : _usecase = usecase,
        super(const SearchInitial());
  final SearchRestaurant _usecase;

  Future<void> searchRestaurant(String restaurantId) async {
    emit(const SearchLoading());
    final result = await _usecase(restaurantId);
    result.fold(
      (failure) => emit(SearchError(message: failure.errorMessage)),
      (restaurants) => emit(SearchLoaded(restaurants: restaurants)),
    );
  }
}
