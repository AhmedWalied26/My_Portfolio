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

  // The safe area above each capture continues the capture's own top edge:
  // the top pixel row is stretched upward, so the colour (including gradients)
  // always matches the app bar and no seam can show at the join.
  // Captures whose first row is busy artwork (posters, search field) use a
  // flat colour instead.
  Color? get _flatColor {
    final name = assetPath.split('/').last;
    const flat = <String, int>{
      '10-movies-1.webp': 0xFF050505,
      '5-30-ecommerce-home.webp': 0xFFFFFFFF,
      '6-31-ecommerce-products.webp': 0xFFFFFFFF,
      '7-32-movies-home.webp': 0xFF000000,
      '8-33-movies-search.webp': 0xFF131313,
      '9-34-movies-browse.webp': 0xFF131313,
    };
    final c = flat[name];
    return c == null ? null : Color(c);
  }

  Widget _safeAreaFill(double safeArea, double screenWidth, double imageHeight) {
    final flat = _flatColor;
    if (flat != null) return ColoredBox(color: flat);
    // Captures are 420x909 (or 780x1688): one pixel row is ~1/900 of the height.
    final rowHeight = imageHeight / 900;
    final scaleY = (safeArea / rowHeight) * 1.5;
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.topCenter,
        minHeight: 0,
        maxHeight: double.infinity,
        child: Transform(
          alignment: Alignment.topCenter,
          transform: Matrix4.diagonal3Values(1, scaleY, 1),
          child: Image.asset(
            assetPath,
            width: screenWidth,
            height: imageHeight,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.none,
          ),
        ),
      ),
    );
  }

  Color get _backColor => _flatColor ?? const Color(0xFF090A0C);

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
            child: ColoredBox(
              color: _backColor,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: safeArea + 1,
                    child: _safeAreaFill(safeArea + 1, screenWidth, imageHeight),
                  ),
                  // The capture starts 1px inside the safe area, so the join
                  // can never show a gap, even on tilted phones.
                  Positioned(
                    top: safeArea - 1,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      assetPath,
                      width: screenWidth,
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                      semanticLabel: semanticLabel,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: safeArea,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
