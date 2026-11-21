import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class TypingNameText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Shader Function(Rect)? shaderCallback;

  const TypingNameText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.start,
    this.shaderCallback,
  });

  @override
  State<TypingNameText> createState() => _TypingNameTextState();
}

enum _TypingPhase {
  typing,
  pausingAtEnd,
  deleting,
  pausingAtStart,
}

class _TypingNameTextState extends State<TypingNameText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _cursorController;
  late final Animation<double> _cursorOpacity;
  Timer? _stepTimer;

  int _characterIndex = 0;
  _TypingPhase _phase = _TypingPhase.typing;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);

    _cursorOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cursorController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final mq = MediaQuery.maybeOf(context);
      if (mq != null && (mq.accessibleNavigation || mq.disableAnimations)) {
        setState(() {
          _reduceMotion = true;
          _characterIndex = widget.text.length;
        });
      } else {
        _scheduleNextStep();
      }
    });
  }

  void _scheduleNextStep() {
    if (!mounted || _reduceMotion) return;

    Duration delay;
    switch (_phase) {
      case _TypingPhase.typing:
        delay = const Duration(milliseconds: 85);
        break;
      case _TypingPhase.pausingAtEnd:
        delay = const Duration(milliseconds: 2200);
        break;
      case _TypingPhase.deleting:
        delay = const Duration(milliseconds: 45);
        break;
      case _TypingPhase.pausingAtStart:
        delay = const Duration(milliseconds: 500);
        break;
    }

    _stepTimer?.cancel();
    _stepTimer = Timer(delay, _handleStep);
  }

  void _handleStep() {
    if (!mounted || _reduceMotion) return;

    setState(() {
      switch (_phase) {
        case _TypingPhase.typing:
          if (_characterIndex < widget.text.length) {
            _characterIndex++;
            if (_characterIndex == widget.text.length) {
              _phase = _TypingPhase.pausingAtEnd;
            }
          }
          break;

        case _TypingPhase.pausingAtEnd:
          _phase = _TypingPhase.deleting;
          break;

        case _TypingPhase.deleting:
          if (_characterIndex > 0) {
            _characterIndex--;
            if (_characterIndex == 0) {
              _phase = _TypingPhase.pausingAtStart;
            }
          }
          break;

        case _TypingPhase.pausingAtStart:
          _phase = _TypingPhase.typing;
          break;
      }
    });

    _scheduleNextStep();
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayedText = _reduceMotion
        ? widget.text
        : widget.text.substring(0, _characterIndex);

    final isCenter = widget.textAlign == TextAlign.center;
    final alignment =
        isCenter ? Alignment.topCenter : Alignment.topLeft;

    final cursorHeight = (widget.style.fontSize ?? 40) * 0.82;

    Widget cursorWidget = AnimatedBuilder(
      animation: _cursorOpacity,
      builder: (context, _) {
        return Opacity(
          opacity: _reduceMotion ? 1.0 : _cursorOpacity.value,
          child: Container(
            margin: const EdgeInsets.only(left: 3, right: 2),
            width: 3.5,
            height: cursorHeight,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );

    Widget buildRich(String content, {bool isPlaceholder = false}) {
      final textSpan = TextSpan(
        style: widget.style,
        children: [
          TextSpan(text: content),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: isPlaceholder
                ? SizedBox(width: 3.5 + 5, height: cursorHeight)
                : cursorWidget,
          ),
        ],
      );

      final richText = Text.rich(
        textSpan,
        textAlign: widget.textAlign,
      );

      if (widget.shaderCallback != null && !isPlaceholder) {
        return ShaderMask(
          shaderCallback: widget.shaderCallback!,
          child: richText,
        );
      }

      return richText;
    }

    return Stack(
      alignment: alignment,
      children: [
        Opacity(
          opacity: 0.0,
          child: buildRich(widget.text, isPlaceholder: true),
        ),
        buildRich(displayedText, isPlaceholder: false),
      ],
    );
  }
}
