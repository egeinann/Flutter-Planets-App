import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpacityNotifier extends StateNotifier<double> {
  OpacityNotifier() : super(0.0); // Başlangıçta opacity 0 (görünmez)

  // Opaklığı değiştirmek için bir fonksiyon
  void setOpacity(double opacity) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      state = opacity;
    });
  }

  // Opaklık değerini hemen 1.0 yaparak animasyonu başlat
  void fadeIn() {
    state = 1.0;
  }
}

// Opaklık durumu için provider
final fadeInProvider = StateNotifierProvider<OpacityNotifier, double>((ref) {
  return OpacityNotifier();
});
