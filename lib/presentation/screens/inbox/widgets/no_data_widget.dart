import 'package:flicker_mail/core/const_gen/assets.gen.dart';
import 'package:flicker_mail/core/l10n/translate_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            Assets.animations.noData.path,
            width: 150,
            height: 150,
          ),
          Text(
            context.l10n.noDataFound,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
