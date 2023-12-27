part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {
  const SearchInitial();
}

final class SearchLoading extends SearchState {
  const SearchLoading();
}

final class SearchLoaded extends SearchState {
  const SearchLoaded({required this.restaurants});
  final List<Restaurant> restaurants;

  @override
  List<Object> get props => [restaurants];
}

final class SearchError extends SearchState {
  const SearchError({required this.message});
  final String message;

  @override
  List<String> get props => [message];
}
