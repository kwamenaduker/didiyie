import 'package:flutter/material.dart';

/// Simple animation helper class to handle staggered animations
class DelayedAnimation extends StatelessWidget {
  final Widget child;
  final int delay;
  final double offset;
  final Axis direction;

  const DelayedAnimation({
    Key? key,
    required this.child,
    required this.delay,
    this.offset = 0.35,
    this.direction = Axis.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: delay)),
      builder: (context, snapshot) {
        return TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: snapshot.connectionState == ConnectionState.done ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutQuint,
          builder: (context, double value, Widget? child) {
            final offset = direction == Axis.horizontal
                ? Offset(this.offset * (1 - value), 0)
                : Offset(0, this.offset * (1 - value));
                
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: offset,
                child: child,
              ),
            );
          },
          child: child,
        );
      },
    );
  }
}
