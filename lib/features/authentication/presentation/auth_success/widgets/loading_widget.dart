import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AuthSuccessLoadingWidget extends StatefulWidget {
  const AuthSuccessLoadingWidget({super.key, required this.onComplete});
  final VoidCallback onComplete;

  @override
  State<AuthSuccessLoadingWidget> createState() =>
      _AuthSuccessLoadingWidgetState();
}

class _AuthSuccessLoadingWidgetState extends State<AuthSuccessLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 900),
    );

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.onComplete.call();
            }
          });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      backgroundColor: Colors.white,
      lineHeight: 40,
      percent: _animation.value,
      animation: false,
      barRadius: const Radius.circular(30),
    );
  }
}
