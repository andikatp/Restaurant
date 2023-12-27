import 'package:dicoding_final/core/errors/error_message.dart';
import 'package:dicoding_final/features/dashboard/domain/usecases/get_restaurants.dart';
import 'package:dicoding_final/shared/entities/restaurant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required GetRestaurants usecase})
      : _usecase = usecase,
        super(const DashboardInitial());
  final GetRestaurants _usecase;

  Future<void> getRestaurants() async {
    emit(const DashboardLoading());
    final result = await _usecase();
    result.fold(
      (failure) => emit(DashboardError(message: errorMessage(failure))),
      (restaurants) => emit(DashboardLoaded(restaurants: restaurants)),
    );
  }
}
