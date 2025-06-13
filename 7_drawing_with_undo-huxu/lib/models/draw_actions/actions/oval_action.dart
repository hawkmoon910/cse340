import 'package:flutter/material.dart';

import '../draw_actions.dart';

// Used to represent an oval by the user
class OvalAction extends DrawAction {
  final Offset point1;
  final Offset point2;
  final Color color;

  OvalAction(this.point1, this.point2, this.color);
}
