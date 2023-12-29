import 'package:auto_route/auto_route.dart';
import 'package:dicoding_final/core/commons/widgets/loading_widget.dart';
import 'package:dicoding_final/core/constants/app_constant.dart';
import 'package:dicoding_final/core/constants/app_sizes.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/search_widget/lottie_state.dart';
import 'package:dicoding_final/features/explore_restaurants/presentation/widgets/shared/restaurant_tile_widget.dart';
import 'package:dicoding_final/features/shared/saved_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SavedRestaurantPage extends StatefulWidget {
  const SavedRestaurantPage({super.key});

  static const routeName = '/saved';

  @override
  State<SavedRestaurantPage> createState() => _SavedRestaurantPageState();
}

class _SavedRestaurantPageState extends State<SavedRestaurantPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<SavedProvider>(context, listen: false).getSavedRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Restaurants'),
      ),
      body: Consumer<SavedProvider>(
        builder: (context, saved, child) {
          print('isLoading: ${saved.isLoading}');
          print('messageOfError: ${saved.messageOfError}');
          print('Number of restaurants: ${saved.restaurants.length}');
          return CustomScrollView(
            slivers: [
              if (saved.isLoading)
                const SliverFillRemaining(child: LoadingWidget()),
              if (saved.messageOfError.isNotEmpty)
                SliverToBoxAdapter(
                  child: Text(saved.messageOfError),
                ),
              if (saved.restaurants.isEmpty)
                const LottieState(lottieAsset: AppConstant.networkErrorLottie),
              const LottieState(lottieAsset: AppConstant.noInternetConnection),
            ],
          );
        },
      ),
    );
  }
}

// SliverFillRemaining(
//             child: FutureBuilder(
//               future: savedProvider.getSavedRestaurant(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const LoadingWidget();
//                 } else if (snapshot.hasError) {
//                   return const LottieState(
//                     lottieAsset: AppConstant.noInternetConnection,
//                   );
//                 } else if (savedProvider.restaurants.isEmpty) {
//                   return const LottieState(
//                     lottieAsset: AppConstant.emptyLottie,
//                   );
//                 } else {
//                   return SliverList.separated(
//                     itemCount: savedProvider.restaurants.length,
//                     itemBuilder: (_, index) {
//                       final restaurant = savedProvider.restaurants[index];
//                       return RestaurantTile(restaurant: restaurant);
//                     },
//                     separatorBuilder: (_, __) => Gap.h8,
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
