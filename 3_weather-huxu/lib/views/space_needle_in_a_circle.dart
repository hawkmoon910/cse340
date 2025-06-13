import 'package:flutter/material.dart';

class SpaceNeedleInACircle extends StatelessWidget {
  const SpaceNeedleInACircle({super.key});

  // Returns a widget tree of circlular Space Needle
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Space Needle', // Accessibility label for Space Needle image
      child: ClipOval( // Clips the child (image) into an oval
        child: Image.asset( // Image
          'assets/spaceneedle.jpeg', // Space Needle image path
          width: 250, // Space Needle image width
          height: 250, // Space Needle image height
          fit: BoxFit.cover, // Makes image fit in container
        ),
      ),
    );
  }
}