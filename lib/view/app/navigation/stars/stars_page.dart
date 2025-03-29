import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/models/starContainerModel.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/app/navigation/stars/star_page.dart';
import 'package:spaceandplanets_app/widgets/meteorWidget/meteorView.dart';

class StarsPage extends StatelessWidget {
  const StarsPage({super.key});

  static List<StarContainermodel> starContainers = [
    StarContainermodel(
      name: "Sun",
      image: "assets/stars/sun.png",
      description: "The closest star to Earth",
      longDescription:
          "The Sun is the star at the center of our solar system. It provides the energy necessary for life on Earth and is the source of heat and light. Its gravitational pull keeps the planets in orbit, and its energy powers Earth's climate systems. The Sun's surface temperature is around 5,500°C, and it is primarily composed of hydrogen and helium.",
      backgroundColor: StarColors.sun,
      size: 20.h,
    ),
    StarContainermodel(
      name: "Proxima Centauri",
      image: "assets/stars/proximaCentauri.png",
      description: "The closest star to the Sun",
      longDescription:
          "Proxima Centauri is a red dwarf star in the Alpha Centauri star system. It is the closest known star to the Sun, located about 4.24 light-years away. Despite its proximity, Proxima Centauri is not visible to the naked eye, as it is much dimmer than the Sun. It is known to have at least one exoplanet, Proxima b, which lies in the habitable zone.",
      backgroundColor: StarColors.proximaCentauri,
      size: 20.h,
    ),
    StarContainermodel(
      name: "Sirius",
      image: "assets/stars/sirius.png",
      description: "The brightest star in the night sky",
      longDescription:
          "Sirius is a binary star system in the constellation Canis Major. It consists of Sirius A, a main-sequence star, and Sirius B, a white dwarf. Sirius A is the brightest star in the night sky, and it is about 8.6 light-years from Earth. Its brightness and proximity make it one of the most well-known stars in the sky.",
      backgroundColor: StarColors.sirius,
      size: 20.h,
    ),
    StarContainermodel(
      name: "Rigel",
      image: "assets/stars/rigel.png",
      description: "A blue supergiant star",
      longDescription:
          "Rigel is a blue supergiant star located in the constellation Orion. It is one of the most luminous stars in the sky and is about 860 light-years away from Earth. Rigel is much more massive than the Sun and will eventually end its life in a supernova explosion. It has a surface temperature of around 11,000°C, giving it a blue hue.",
      backgroundColor: StarColors.rigel,
      size: 20.h,
    ),
    StarContainermodel(
      name: "Betelgeuse",
      image: "assets/stars/betelgeuse.png",
      description: "A red supergiant star",
      longDescription:
          "Betelgeuse is a red supergiant star in the constellation Orion. It is one of the largest and most luminous stars visible to the naked eye. Located about 640 light-years from Earth, Betelgeuse is nearing the end of its life and will eventually explode in a supernova. Its size and color make it a prominent feature in the night sky.",
      backgroundColor: StarColors.betelgeuse,
      size: 20.h,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          meteors(),
          starContainersListViewBuilder(context),
        ],
      ),
    );
  }

  // *** LISTVIEW BUILDER ***
  Widget starContainersListViewBuilder(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Explore the\nStars !!",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              const Expanded(
                child: Image(
                  image: AssetImage("assets/images/pink_stars.png"),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 55.h,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: starContainers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: OpenContainer(
                  transitionType: ContainerTransitionType.fade,
                  closedElevation: 0,
                  openElevation: 0,
                  transitionDuration: const Duration(milliseconds: 400),
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  openShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  closedColor: Colors.transparent,
                  openColor: Colors.transparent,
                  closedBuilder: (context, action) {
                    return SizedBox(
                      width: 200,
                      height: 50.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 45.w,
                            height: 35.h,
                            padding: EdgeInsets.only(top: 10.h),
                            decoration: BoxDecoration(
                              color: starContainers[index].backgroundColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: starContainers[index].backgroundColor,
                                  blurRadius: 7,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Text(
                                  starContainers[index].name,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                Text(
                                  starContainers[index].description,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 2.h),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              starContainers[index].image,
                              fit: BoxFit.scaleDown,
                              height: starContainers[index].size,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return StarPage(star: starContainers[index]);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // *** METEOR ***
  Widget meteors() {
    return Center(
      child: MeteorWidget(
        duration: const Duration(seconds: 3),
        numberOfMeteors: 100,
        child: Container(),
      ),
    );
  }
}
