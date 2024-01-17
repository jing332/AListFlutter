import 'package:flutter/material.dart';

class SwitchFloatingButton extends StatefulWidget {
  final bool isSwitch;
  final ValueChanged<bool> onSwitchChange;

  const SwitchFloatingButton(
      {super.key, required this.isSwitch, required this.onSwitchChange});

  @override
  State<SwitchFloatingButton> createState() => _SwitchFloatingButtonState();
}

class _SwitchFloatingButtonState extends State<SwitchFloatingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.isSwitch
        ? const Icon(Icons.stop, size: 48)
        : const Icon(Icons.send, size: 32);

    return FloatingActionButton(
      onPressed: () {
        if (widget.isSwitch && _controller.isCompleted) {
          _controller.reverse(from: 0.5);
        } else {
          _controller.forward(from: 0.5);
        }
        widget.onSwitchChange(!widget.isSwitch);
      },
      backgroundColor: widget.isSwitch
          ? Theme.of(context).colorScheme.inversePrimary
          : Theme.of(context).colorScheme.primaryContainer,
      elevation: 8.0,
      shape: const CircleBorder(),
      child: RotationTransition(
        turns: _animation,
        child: icon,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
