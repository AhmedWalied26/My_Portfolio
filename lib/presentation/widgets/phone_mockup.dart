import 'package:flutter/material.dart';

/// A phone with a floating iPhone 16-style Dynamic Island.
/// The added top safe area belongs to the frame, not the app capture:
/// screenshots remain complete below it, including their top controls.
class PhoneMockup extends StatelessWidget {
  final String assetPath;
  final double height;
  final String semanticLabel;

  const PhoneMockup({
    super.key,
    required this.assetPath,
    required this.height,
    required this.semanticLabel,
  });

  static const double _aspect = 390 / 844;

  // Match the safe area to the upper edge of each existing app capture.
  // No screenshot assets are edited or stretched to make room for the island.
  Color get _safeAreaColor {
    final name = assetPath.split('/').last;
    const exact = <String, int>{"1-26-mazra3ty-home.webp": 0xFF195130, "2-2-27-mazra3ty-collections.webp": 0xFF195130, "3-28-mazra3ty-outgoings.webp": 0xFF195130, "4-29-mazra3ty-history.webp": 0xFF195130, "1-61-package-nodata.webp": 0xFFF8F9FF, "2-62-package-search.webp": 0xFFF8F9FF, "3-63-package-nointernet.webp": 0xFFF8F9FF, "4-64-package-error.webp": 0xFFF8F9FF, "5-65-package-permission.webp": 0xFFF8F9FF, "5-30-ecommerce-home.webp": 0xFFFFFFFF, "6-31-ecommerce-products.webp": 0xFFFFFFFF, "7-32-movies-home.webp": 0xFF000000, "1-movies-search-clean.webp": 0xFF303435, "19-islami-1.webp": 0xFF1F1F1F, "20-islami-2.webp": 0xFF181818, "21-islami-3.webp": 0xFF483A2A, "22-islami-4.webp": 0xFF161616};
    final exactColor = exact[name];
    if (exactColor != null) return Color(exactColor);
    if (name.contains('package')) return const Color(0xFFF6F8FE);
    if (name.startsWith('4-mazra3ty')) return const Color(0xFF195130);
    if (name.contains('mazra3ty')) return const Color(0xFFF5F8F5);
    if (name.contains('ecommerce')) return const Color(0xFF014282);
    if (name.contains('evently')) return const Color(0xFFF4F7FF);
    if (name.contains('news')) return Colors.white;
    if (name.contains('movies')) return const Color(0xFF131313);
    if (name.contains('islami')) return const Color(0xFF211F1D);
    return const Color(0xFF151515);
  }

  @override
  Widget build(BuildContext context) {
    final bezel = height * 0.012;
    final safeArea = height * 0.064;
    final imageHeight = height - bezel * 2 - safeArea;
    final screenWidth = imageHeight * _aspect;
    final width = screenWidth + bezel * 2;
    final outerRadius = height * 0.075;
    final screenRadius = outerRadius - bezel;
    final islandHeight = height * 0.034;
    final islandWidth = screenWidth * 0.32;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF090A0C),
          borderRadius: BorderRadius.circular(outerRadius),
          border: Border.all(color: const Color(0xFF4A5059), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(bezel),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenRadius),
            child: ColoredBox(color: _safeAreaColor, child: Column(
              children: [
                SizedBox(
                  height: safeArea,
                  width: screenWidth,
                  child: ColoredBox(
                    color: _safeAreaColor,
                    child: Align(
                      alignment: const Alignment(0, -0.05),
                      child: Container(
                        width: islandWidth,
                        height: islandHeight,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(islandHeight / 2),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    assetPath,
                    width: screenWidth,
                    fit: BoxFit.contain,
                    semanticLabel: semanticLabel,
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
