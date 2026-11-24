import 'package:flutter/material.dart';

/// Draws an app screenshot inside a stylized phone frame
/// (dark bezel, rounded corners, visible top notch).
///
/// The inner screen area is sized to the exact aspect ratio of the
/// source captures ([_aspect]), so `BoxFit.cover` renders every
/// screenshot pixel-perfect with no cropping of edge content. The
/// notch sits entirely inside a dedicated top bezel band, so it is
/// clearly visible while never covering any pixel of the screenshot.
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
    // Bezel proportions: thin sides, a slim chin, and a taller top band
    // that hosts the notch. The remaining screen area keeps the exact
    // capture aspect, so the screenshot is never cropped or letterboxed.
    final sidePad = height * 0.014;
    final topPad = height * 0.052;
    final bottomPad = height * 0.018;
    final screenWidth = (height - topPad - bottomPad) * _aspect;
    final width = screenWidth + 2 * sidePad;

    final outerRadius = height * 0.075;
    final screenRadius = (outerRadius - sidePad).clamp(0.0, outerRadius);

    final notchHeight = topPad * 0.52;
    final notchWidth = screenWidth * 0.46;

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
            top: topPad,
            bottom: bottomPad,
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
          // Notch: centered in the top bezel band, lifted from the bezel
          // by a slightly lighter fill and a hairline border so it reads
          // as a real phone notch at any mockup size.
          Positioned(
            top: (topPad - notchHeight) / 2,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: notchWidth,
                height: notchHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B2536),
                  borderRadius: BorderRadius.circular(notchHeight / 2),
                  border: Border.all(
                    color: const Color(0xFF2A3B4A),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
