import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// 🌠 Meteor sınıfı (Animasyonu yönetmek için)
class Meteor {
  final double startX;
  final double startY;
  late double endX;
  late double endY;
  final double delay;
  final double duration;

  Meteor(double angle, Size size)
      : startX = Random().nextDouble() * size.width / 2,
        startY = Random().nextDouble() * size.height / 4 - size.height / 4,
        delay = Random().nextDouble(),
        duration = 0.3 + Random().nextDouble() * 0.7 {
    var distance = size.height / 3;
    endX = startX + cos(angle) * distance;
    endY = startY + sin(angle) * distance;
  }
}

// 🌠 Meteor State Notifier
class MeteorNotifier extends StateNotifier<List<Meteor>> {
  final Size size;
  final double angle;

  MeteorNotifier(this.size, {this.angle = pi / 4}) : super([]) {
    _initializeMeteors();
  }

  void _initializeMeteors() {
    state = List.generate(10, (_) => Meteor(angle, size));
  }
}

// 🌠 Riverpod Provider
final meteorProvider = StateNotifierProvider.family<MeteorNotifier, List<Meteor>, Size>(
  (ref, size) => MeteorNotifier(size),
);