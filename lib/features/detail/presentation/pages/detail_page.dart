import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/commons/widgets/network_error_widget.dart';
import 'package:dicoding_final/core/extensions/context_extension.dart';
import 'package:dicoding_final/features/detail/presentation/cubit/detail_cubit.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/appbar_detail_widget.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/detail_widget.dart';
import 'package:dicoding_final/features/detail/presentation/widgets/menu_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  static const routeName = '/detail';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void getRestaurantFromCubit() {
    final restaurantId = context.modalRoute!.settings.arguments! as String;
    context.read<DetailCubit>().getDetailRestaurant(restaurantId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getRestaurantFromCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<DetailCubit, DetailState>(
        listener: (context, state) {
          if (state is DetailError) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
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
                DetailWidget(restaurant: restaurant),
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
