import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/app/navigation/planets/planets_page.dart';
import 'package:spaceandplanets_app/view/app/navigation/stars/stars_page.dart';
import 'package:spaceandplanets_app/view/app/navigation/state/NavigationState.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            SpaceIcons.logout,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        backgroundColor: SpaceColors.backgroundColor,
        title: Text(
          "Home",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          PlanetsPage(),
          StarsPage(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: SpaceColors.firstColor,
            endIndent: 10.w,
            indent: 10.w,
            thickness: 1,
          ),
          SalomonBottomBar(
            selectedColorOpacity: 0.2,
            currentIndex: currentIndex,
            onTap: (index) =>
                ref.read(navigationProvider.notifier).changeIndex(index),
            items: [
              SalomonBottomBarItem(
                selectedColor: PlanetColors.saturnbackgroundColor,
                icon: Image(
                  image: const AssetImage("assets/planets/saturn.png"),
                  fit: BoxFit.scaleDown,
                  height: 4.h,
                ),
                title: Text(
                  "Planets",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SalomonBottomBarItem(
                selectedColor: Colors.blue,
                icon: Image(
                  image: const AssetImage("assets/images/starFlat.png"),
                  fit: BoxFit.scaleDown,
                  height: 4.h,
                ),
                title: Text(
                  "Stars",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
