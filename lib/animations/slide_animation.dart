import 'package:flutter/material.dart';

/// Available entrance directions for [SlideAnimation].
enum SlideDirection { fromBottom, fromTop, fromLeft, fromRight }

/// A reusable widget that animates its child into view using a [SlideTransition]
/// combined with a gentle [FadeTransition], backed by an [AnimationController]
/// and [CurvedAnimation] with [Curves.easeOutCubic].
class SlideAnimation extends StatefulWidget {
  final Widget child;
  final SlideDirection direction;
  final double offsetDistance;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  const SlideAnimation({
    super.key,
    required this.child,
    this.direction = SlideDirection.fromBottom,
    this.offsetDistance = 0.15,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);

    Offset startOffset;
    switch (widget.direction) {
      case SlideDirection.fromBottom:
        startOffset = Offset(0, widget.offsetDistance);
        break;
      case SlideDirection.fromTop:
        startOffset = Offset(0, -widget.offsetDistance);
        break;
      case SlideDirection.fromLeft:
        startOffset = Offset(-widget.offsetDistance, 0);
        break;
      case SlideDirection.fromRight:
        startOffset = Offset(widget.offsetDistance, 0);
        break;
    }

    _offsetAnimation = Tween<Offset>(
      begin: startOffset,
      end: Offset.zero,
    ).animate(curved);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) {
      return widget.child;
    }

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    );
  }
}
