import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/models/starContainerModel.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';

class StarPage extends StatelessWidget {
  final StarContainermodel star;

  StarPage({super.key, required this.star});
  final double imageWidth = 40.w; // Resmin genişliği
  final double featuresWidth = 40.w;
  final double featuresHeight = 100.h;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: star.backgroundColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          starImageAnimated(),
          topAppBar(context),
          featuresAnimated(),
          starLongDescription(context),
        ],
      ),
    );
  }

  // *** STAR FEATURES ***
  TweenAnimationBuilder<double> featuresAnimated() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: -100.w, end: 25.w - (featuresWidth / 2)),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, leftPosition, child) {
        return Positioned(
          left: leftPosition,
          top: featuresHeight / 2, // Ekranın ortasına hizalama
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Temperature: ",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        star.temperature,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: SpaceColors.secondaryColor),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Diameter: ",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        star.diameter,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: SpaceColors.secondaryColor),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Satellites: ",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        star.planets.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: SpaceColors.secondaryColor),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // *** STARLONG DESCRIPTION ***
  Column starLongDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            star.longDescription!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // *** TOP APPBAR ***
  Align topAppBar(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(SpaceIcons.back),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Text(
                    star.name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = star.backgroundColor, // Kenarlık rengi
                        ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    star.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // *** STAR IMAGE ANIAMTED ***
  TweenAnimationBuilder<double> starImageAnimated() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 100.w, end: 50.w - (imageWidth / 2)),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, leftPosition, child) {
        return Positioned(
          left: leftPosition,
          child: Image.asset(
            star.image,
            fit: BoxFit.contain,
            height: 50.h,
          ),
        );
      },
    );
  }
}
