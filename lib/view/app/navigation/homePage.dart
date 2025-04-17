import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:spaceandplanets_app/services/auth_service.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/app/navigation/navigationPages/planets/planets_page.dart';
import 'package:spaceandplanets_app/view/app/navigation/navigationPages/profile/profile_page.dart';
import 'package:spaceandplanets_app/view/app/navigation/navigationPages/stars/stars_page.dart';
import 'package:spaceandplanets_app/view/app/navigation/state/NavigationState.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = AuthService();
    final currentIndex = ref.watch(navigationProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SpaceColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(SpaceIcons.logout),
          onPressed: () async {
            await authService.signOut(context);
            
          },
        ),
        centerTitle: true,
        title: Text(
          "HOME",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          PlanetsPage(),
          StarsPage(),
          ProfilePage(),
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
              SalomonBottomBarItem(
                selectedColor: Colors.red,
                icon: const Icon(SpaceIcons.user),
                title: Text(
                  "Profile",
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

extension on GoogleSignInAccount? {
  void signOut() {}
}
