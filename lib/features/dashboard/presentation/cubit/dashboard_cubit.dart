import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:dicoding_final/features/dashboard/domain/usecases/get_restaurants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required GetRestaurants getRestaurants})
      : _getRetaurants = getRestaurants,
        super(const DashboardInitial());
  final GetRestaurants _getRetaurants;

  Future<void> getRestaurants() async {
    emit(const DashboardLoading());
    final result = await _getRetaurants();
    result.fold(
      (failure) => emit(DashboardError(message: failure.errorMessage)),
      (restaurants) => emit(DashboardLoaded(restaurants: restaurants)),
    );
  }
}
