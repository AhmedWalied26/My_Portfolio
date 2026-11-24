import 'package:flutter/material.dart';

/// Draws an app screenshot inside a stylized phone frame
/// (dark bezel, rounded corners, notch).
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
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(height * 0.018),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(outerRadius * 0.78),
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                  semanticLabel: semanticLabel,
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.018,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: width * 0.30,
                height: height * 0.026,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0F19),
                  borderRadius: BorderRadius.circular(height * 0.013),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
