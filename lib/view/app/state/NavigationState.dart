import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationState extends StateNotifier<int> {
  NavigationState() : super(0);

  void changeIndex(int index) {
    state = index;
  }
}

final navigationProvider = StateNotifierProvider<NavigationState, int>((ref) => NavigationState());