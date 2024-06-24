import 'package:flutter/material.dart';

class ExternalAnimation extends StatefulWidget {
  const ExternalAnimation({super.key});

  @override
  State<ExternalAnimation> createState() => _ExternalAnimationState();
}

class _ExternalAnimationState extends State<ExternalAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _containerAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _containerAnimation = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Tashqi animatsiyalar"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _containerAnimation,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${(_animationController.value * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: _containerAnimation.value,
                height: 50,
                color: Colors.blue,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animationController.repeat();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
