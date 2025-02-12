import 'package:flutter/material.dart';

class AnimatedFavoriteButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AnimatedFavoriteButton({super.key, required this.onPressed});

  @override
  AnimatedFavoriteButtonState createState() => AnimatedFavoriteButtonState();
}

class AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton> {
  bool isActive = false;

  void _toggle() {
    setState(() {
      isActive = !isActive;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
            reverseCurve: Curves.elasticOut,
          );
          return ScaleTransition(scale: curvedAnimation, child: child);
        },
        child: IconButton(
          key: ValueKey(isActive),
          icon: Icon(
            Icons.favorite,
            color: isActive ? Color(0xFF3E9C4B) : Colors.black,
          ),
          onPressed: _toggle,
        ),
      ),
    );
  }
}
