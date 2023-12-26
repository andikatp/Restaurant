import 'package:dicoding_final/core/res/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CupertinoActivityIndicator(color: Colours.primaryColor),
      ),
    );
  }
}
