import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/appbar_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key});

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: SafeArea(
        child: BlocConsumer<RestaurantCubit, RestaurantState>(
          listener: (context, state) {
            if (state is RestaurantError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return const LoadingWidget();
            }
            if (state is RestaurantLoaded) {
              final restaurants = state.restaurants;
              // TODO(Restaurants): create a card list containing restaurant.
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
