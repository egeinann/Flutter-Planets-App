import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/models/planetContainerModel.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/app/navigation/planets/planet_page.dart';
import 'package:spaceandplanets_app/widgets/meteorWidget/meteorView.dart';

class PlanetsPage extends StatelessWidget {
  const PlanetsPage({super.key});

  static List<Planetcontainermodel> planetContainers = [
    Planetcontainermodel(
      name: "Mercury",
      image: "assets/planets/mercury.png",
      description: "The smallest and closest planet to the Sun",
      longDescription:
          "Mercury, the swift and mysterious messenger of the cosmos, orbits the Sun at an incredible speed. Its surface, covered in ancient craters, tells a tale of relentless asteroid impacts. With no true atmosphere to shield it, Mercury endures scorching heat during the day and freezing darkness at night, making it one of the most extreme worlds in our Solar System.",
      backgroundColor: PlanetColors.mercurymarsbackgroundColor,
      size: 20.h,
    ),
    Planetcontainermodel(
      name: "Venus",
      image: "assets/planets/venus.png",
      description: "The hottest planet with a thick atmosphere",
      longDescription:
          "Venus, often called Earth's twin, is anything but hospitable. Beneath its golden clouds lies a world where temperatures soar high enough to melt lead. Its thick, toxic atmosphere traps heat in a runaway greenhouse effect, creating a hellish landscape of volcanic plains and crushing pressure. Despite its harsh conditions, Venus remains one of the most fascinating and mysterious planets in the Solar System.",
      backgroundColor: PlanetColors.venusbackgroundColor,
      size: 20.h,
    ),
    Planetcontainermodel(
      name: "Earth",
      image: "assets/planets/earth.png",
      description: "The only planet known to support life",
      longDescription:
          "Earth, the cradle of life, is a dazzling oasis in the vastness of space. With its vast oceans, lush forests, and vibrant ecosystems, it remains the only known celestial body to harbor life. The perfect balance of atmosphere, water, and warmth makes it a true cosmic jewel, reminding us of the delicate nature of existence in the universe.",
      backgroundColor: PlanetColors.earthBackgroundColor,
      size: 20.h,
    ),
    Planetcontainermodel(
      name: "Mars",
      image: "assets/planets/mars.png",
      description: "The Red Planet, a future exploration target",
      longDescription:
          "Mars, the enigmatic Red Planet, has long captivated humanity with its rusty landscapes and towering dust storms. Its thin atmosphere and frozen deserts hint at a past where rivers once flowed. With its towering volcanoes and deep canyons, Mars stands as a frontier for future exploration, fueling dreams of one day setting foot on its surface.",
      backgroundColor: PlanetColors.marsbackgroundColor,
      size: 20.h,
    ),
    Planetcontainermodel(
      name: "Jupiter",
      image: "assets/planets/jupiter.png",
      description: "The largest planet in the Solar System",
      longDescription:
          "Jupiter, the undisputed king of planets, looms as a massive gas giant with a stormy, ever-changing atmosphere. The Great Red Spot, a storm larger than Earth, has raged for centuries, while its swirling bands of clouds dance in a mesmerizing display. With over 90 known moons, including the intriguing Europa and Ganymede, Jupiter is a world of wonder and endless mysteries.",
      backgroundColor: PlanetColors.jupiterbackgroundColor,
      size: 20.h,
    ),
    Planetcontainermodel(
      name: "Saturn",
      image: "assets/planets/saturn.png",
      description: "A gas giant with stunning rings",
      longDescription:
          "Saturn, the crown jewel of the Solar System, is adorned with dazzling rings made of ice and rock. These shimmering bands, stretching for thousands of miles, make it one of the most breathtaking sights in the cosmos. Beyond its beauty, Saturn's many moons, like Titan and Enceladus, hold secrets that may one day redefine our understanding of life beyond Earth.",
      backgroundColor: PlanetColors.saturnbackgroundColor,
      size: 20.h,
    ),
    Planetcontainermodel(
      name: "Neptune",
      image: "assets/planets/neptune.png",
      description: "The distant blue planet",
      longDescription:
          "Neptune, the farthest planet from the Sun, is a cold and mysterious world shrouded in deep blue clouds. Known for its intense winds, Neptune's atmosphere is a mix of hydrogen, helium, and methane, giving it its distinctive color. Its Great Dark Spot, a massive storm, was once thought to be a permanent feature, but it has since disappeared. With its five known rings and 14 moons, including Triton, Neptune remains one of the most intriguing planets in our Solar System.",
      backgroundColor: PlanetColors.neptunebackgroundColor,
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
          planetContainersListViewBuilder(context),
        ],
      ),
    );
  }

  // *** LISTVIEW BUILDER ***
  Widget planetContainersListViewBuilder(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Explore our solar system !!",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              const Expanded(
                child: Image(
                  image: AssetImage("assets/images/void.png"),
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
            itemCount: planetContainers.length,
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
                      width: 50.w,
                      height: 50.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 45.w,
                            height: 35.h,
                            padding: EdgeInsets.only(top: 10.h),
                            decoration: BoxDecoration(
                              color: planetContainers[index].backgroundColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      planetContainers[index].backgroundColor,
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
                                  planetContainers[index].name,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                Text(
                                  planetContainers[index].description,
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
                              planetContainers[index].image,
                              fit: BoxFit.scaleDown,
                              height: planetContainers[index].size,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return PlanetPage(planet: planetContainers[index]);
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
