import 'package:flutter/material.dart';

/// Draws an app screenshot inside a stylized phone frame
/// (dark bezel, rounded corners, notch).
///
/// The inner screen area is sized to the exact aspect ratio of the
/// source captures ([_aspect]), so `BoxFit.cover` renders every
/// screenshot pixel-perfect with no cropping of edge content, and the
/// notch sits inside the top bezel instead of covering screen content.
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

  @override
  Widget build(BuildContext context) {
    final width = height * _aspect;
    final outerRadius = height * 0.085;

    // Thin side bezels and a slightly thicker top/bottom bezel chosen so
    // the remaining screen area matches the screenshot aspect exactly.
    final sidePad = height * 0.012;
    final screenWidth = width - 2 * sidePad;
    final screenHeight = screenWidth / _aspect;
    final verticalPad = (height - screenHeight) / 2;
    final screenRadius = outerRadius - sidePad;

    final notchHeight = verticalPad * 0.72;
    final notchWidth = width * 0.30;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F19),
        borderRadius: BorderRadius.circular(outerRadius),
        border: Border.all(color: const Color(0xFF2A3B4A), width: 1.4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: verticalPad,
            bottom: verticalPad,
            left: sidePad,
            right: sidePad,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenRadius),
              child: Image.asset(
                assetPath,
                fit: BoxFit.cover,
                semanticLabel: semanticLabel,
              ),
            ),
          ),
          Positioned(
            top: (verticalPad - notchHeight) / 2,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: notchWidth,
                height: notchHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0F19),
                  borderRadius: BorderRadius.circular(notchHeight / 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
