import 'package:flutter/material.dart';

class StarContainermodel {
  String name;
  String image;
  String description;
  String? longDescription = "";
  Color backgroundColor;
  double size;
  String temperature;
  String diameter;
  int planets;

  StarContainermodel({
    required this.name,
    required this.image,
    required this.description,
    this.longDescription,
    required this.backgroundColor,
    required this.size,
    required this.temperature,
    required this.diameter,
    required this.planets,
  });
}
