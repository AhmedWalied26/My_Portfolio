import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnimatedReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;
  final Axis slideAxis;

  const AnimatedReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
    this.slideOffset = 30.0,
    this.slideAxis = Axis.vertical,
  });

  @override
  State<AnimatedReveal> createState() => _AnimatedRevealState();
}

class _AnimatedRevealState extends State<AnimatedReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  Timer? _delayTimer;
  bool _hasTriggered = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    final begin = widget.slideAxis == Axis.vertical
        ? Offset(0, widget.slideOffset / 100)
        : Offset(widget.slideOffset / 100, 0);

    _slideAnimation = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasTriggered) {
        _checkVisibility();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newPosition = Scrollable.maybeOf(context)?.position;
    if (_scrollPosition != newPosition) {
      _scrollPosition?.removeListener(_onScroll);
      _scrollPosition = newPosition;
      _scrollPosition?.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (!_hasTriggered) {
      _checkVisibility();
    }
  }

  void _checkVisibility() {
    if (_hasTriggered || !mounted) return;

    final renderObject = context.findRenderObject();
    if (renderObject == null || !renderObject.attached) return;

    final viewport = RenderAbstractViewport.maybeOf(renderObject);
    if (viewport == null) {
      _triggerAnimation();
      return;
    }

    final scrollPosition = Scrollable.maybeOf(context)?.position;
    if (scrollPosition == null || !scrollPosition.hasPixels) {
      _triggerAnimation();
      return;
    }

    final revealOffset = viewport.getOffsetToReveal(renderObject, 0.0);
    final scrollOffset = scrollPosition.pixels;
    final viewportHeight = scrollPosition.viewportDimension;
    final objectTop = revealOffset.offset;
    final threshold = viewportHeight * 0.92;

    if (objectTop <= scrollOffset + threshold) {
      _triggerAnimation();
    }
  }

  void _triggerAnimation() {
    if (_hasTriggered || !mounted) return;
    _hasTriggered = true;
    _scrollPosition?.removeListener(_onScroll);

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      _delayTimer = Timer(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_onScroll);
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
