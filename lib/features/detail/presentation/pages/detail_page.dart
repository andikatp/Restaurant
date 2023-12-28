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
class DetailPage extends StatefulWidget implements AutoRouteWrapper {
  const DetailPage({
    required this.restaurantId,
    super.key,
  });

  static const routeName = '/detail';
  final String restaurantId;

  @override
  State<DetailPage> createState() => _DetailPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<DetailCubit>(
      create: (context) => sl<DetailCubit>(),
      child: this,
    );
  }
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getRestaurantFromCubit() {
    final restaurantId = widget.restaurantId;
    context.read<DetailCubit>().getDetailRestaurant(restaurantId);
  }

  void addReview(String restaurantId, String review) {
    context.read<DetailCubit>().addReview(restaurantId, review);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getRestaurantFromCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: BlocConsumer<DetailCubit, DetailState>(
        listener: (context, state) {
          if (state is DetailError) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ReviewAdded) {
            getRestaurantFromCubit();
          }
        },
        builder: (context, state) {
          if (state is DetailLoading) {
            return const LoadingWidget();
          }
          if (state is DetailLoaded) {
            final restaurant = state.restaurant;
            return CustomScrollView(
              slivers: [
                AppBarDetail(restaurant: restaurant),
                DetailWidget(restaurant: restaurant, addReview: addReview),
                MenuWidget(restaurant: restaurant),
              ],
            );
          }
          return NetworkErrorWidget(onRetry: getRestaurantFromCubit);
        },
      ),
    );
  }
}
