import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/commons/widgets/restaurant_tile_widget.dart';
import 'package:dicoding_final/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:dicoding_final/features/dashboard/presentation/widgets/appbar_widget.dart';
import 'package:dicoding_final/features/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const routeName = 'dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    context.read<DashboardCubit>().getRestaurants();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DashboardCubit, DashboardState>(
          listener: (context, state) {
            if (state is DashboardError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const LoadingWidget();
            }
            if (state is DashboardLoaded) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  AppBarWidget(
                    controller: _controller,
                  ),
                  SliverList.separated(
                    itemCount: state.restaurants.length,
                    itemBuilder: (_, index) {
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
