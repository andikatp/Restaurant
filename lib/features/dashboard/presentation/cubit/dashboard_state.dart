part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardLoaded extends DashboardState {
  const DashboardLoaded({required this.restaurants});
  final List<Restaurant> restaurants;

  @override
  List<Object> get props =>
      restaurants.map((restaurant) => restaurant.id).toList();
}

final class DashboardError extends DashboardState {
  const DashboardError({required this.message});
  final String message;
  
  @override
  List<Object> get props => [message];
}
