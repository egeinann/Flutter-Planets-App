import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

class CustomBottomSheet {
  static void show({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: SpaceColors.backgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Klavye açıldığında yukarı iter
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 80.w,
              minWidth: 80.w,
              maxHeight: 80.h, // Maksimum yükseklik
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: SpaceColors.firstColor,
                      blurRadius: 5,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // İçeriğin boyutuna göre küçülür
                  children: [
                    child, // Kullanıcının verdiği widget burada yer alır
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
