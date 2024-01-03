import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/commons/widgets/network_error_widget.dart';
import 'package:dicoding_final/core/services/injection_container.dart';
import 'package:dicoding_final/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/appbar_detail_widget.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/detail_widget.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DetailPage extends StatelessWidget implements AutoRouteWrapper {
  const DetailPage({
    required this.restaurantId,
    super.key,
  });
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailCubit>()
      ..getDetailRestaurant(restaurantId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return const LoadingWidget();
          }
          if (state is DetailLoaded) {
            final restaurant = state.restaurant;
            return CustomScrollView(
              slivers: [
                AppBarDetail(restaurant: restaurant),
                DetailWidget(
                  restaurant: restaurant,
                  addReview: cubit.addReview,
                ),
                MenuWidget(restaurant: restaurant),
              ],
            );
          }
          if (state is DetailError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            });
            return NetworkErrorWidget(
              onRetry: () => cubit.getDetailRestaurant(restaurantId),
            );
          }
          if (state is ReviewAdded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getDetailRestaurant(restaurantId);
            });
          }
          return NetworkErrorWidget(
            onRetry: () => cubit.getDetailRestaurant(restaurantId),
          );
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<DetailCubit>(
      create: (context) => sl<DetailCubit>(),
      child: this,
    );
  }
}
