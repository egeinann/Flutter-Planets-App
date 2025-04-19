import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:spaceandplanets_app/models/planetContainerModel.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';

class PlanetPage extends StatelessWidget {
  final Planetcontainermodel planet;

  PlanetPage({super.key, required this.planet});
  final double imageWidth = 40.w; // Resmin genişliği
  final double featuresWidth = 40.w;
  final double featuresHeight = 100.h;
  @override
  Widget build(BuildContext context) {
    final planetImageAnimatedWidget = planetImageAnimated();
    final topAppBarWidget = topAppBar(context);
    final featuresAnimatedWidget = featuresAnimated();
    final longDescriptionWidget = longDescription(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: planet.backgroundColor,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            planetImageAnimatedWidget,
            topAppBarWidget,
            featuresAnimatedWidget,
            longDescriptionWidget,
          ],
        ),
      ),
    );
  }

  // *** FEATURES ***
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
                        planet.temperature,
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
                        planet.diameter,
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
                        planet.satellites.toString(),
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

  // *** PLANET IMAGE ANIMATED ***
  TweenAnimationBuilder<double> planetImageAnimated() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 100.w, end: 50.w - (imageWidth / 2)),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, leftPosition, child) {
        return Positioned(
          left: leftPosition,
          child: Image.asset(
            planet.image,
            fit: BoxFit.contain,
            height: 40.h,
          ),
        );
      },
    );
  }

  // *** LONG DESCRIPTION ***
  Column longDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            planet.longDescription!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // *** TOP POP BUTTON AND PLANETNAME ***
  Align topAppBar(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
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
                    planet.name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = planet.backgroundColor, // Kenarlık rengi
                        ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    planet.name,
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
}
