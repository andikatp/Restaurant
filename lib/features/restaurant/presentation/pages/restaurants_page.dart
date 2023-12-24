import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/appbar_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  static const routeName = 'home';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  @override
  void initState() {
    context.read<RestaurantCubit>().getRestaurants();
    super.initState();
  }

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
              return CustomScrollView(
                slivers: [
                  SliverAnimatedList(
                    initialItemCount: state.restaurants.length,
                    itemBuilder: (context, index, animation) {
                      final restaurants = state.restaurants[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Image.network(restaurants.pictureId),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
