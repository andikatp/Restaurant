import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/cubit/explore_restaurants_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ExploreRestaurantsPage extends StatelessWidget
    implements AutoRouteWrapper {
  const ExploreRestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExploreRestaurantsCubit>(
          create: (_) => sl<ExploreRestaurantsCubit>(),
        ),
      ],
      child: const AutoRouter(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}
