import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/appbar_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/loading_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/restaurant_tile_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/widgets/search_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  static const routeName = 'home';

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    context.read<RestaurantCubit>().getRestaurants();
  }

  void search(String restaurant) =>
      context.read<RestaurantCubit>().searchRestaurants(restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                physics: const BouncingScrollPhysics(),
                slivers: [
                  appBarWidget(
                    ctx: context,
                    controller: _controller,
                    search: search,
                  ),
                  if (state.restaurants.isEmpty) const SearchEmpty(),
                  SliverList.separated(
                    itemCount: state.restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = state.restaurants[index];
                      return RestaurantTile(restaurant: restaurant);
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
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
