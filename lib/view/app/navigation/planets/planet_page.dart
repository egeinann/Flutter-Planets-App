import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:spaceandplanets_app/models/planetContainerModel.dart';
import 'package:spaceandplanets_app/utils/icons.dart';

class PlanetPage extends StatelessWidget {
  final Planetcontainermodel planet;

  PlanetPage({super.key, required this.planet});
  final double imageWidth = 40.w; // Resmin genişliği
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: planet.backgroundColor,
      body: Stack(
        children: [
          TweenAnimationBuilder<double>(
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
          ),
          Align(
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
                          planet.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color =
                                      planet.backgroundColor, // Kenarlık rengi
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
          ),
          Column(
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
          ),
        ],
      ),
    );
  }
}
