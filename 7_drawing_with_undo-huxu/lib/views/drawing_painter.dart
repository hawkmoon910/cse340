import 'package:drawing_with_undo/models/draw_actions/draw_actions.dart';
import 'package:drawing_with_undo/models/drawing.dart';
import 'package:drawing_with_undo/providers/drawing_provider.dart';
import 'package:flutter/material.dart';

class DrawingPainter extends CustomPainter {
  final Drawing _drawing;
  final DrawingProvider _provider;

  DrawingPainter(DrawingProvider provider) : _drawing = provider.drawing, _provider = provider;

  // Paints the action onto the canvas
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    canvas.clipRect(rect); // make sure we don't scribble outside the lines.

    final erasePaint = Paint()..blendMode = BlendMode.clear;
    canvas.drawRect(rect, erasePaint);

    for (final action in _provider.drawing.drawActions){
      _paintAction(canvas, action, size);
    }

    // Paint pending action
    _paintAction(canvas, _provider.pendingAction, size);

  }

  // Determines what you paint on the canvas for that action
  void _paintAction(Canvas canvas, DrawAction action, Size size){
    final Rect rect = Offset.zero & size;
    final erasePaint = Paint()..blendMode = BlendMode.clear;

    switch (action) {
        case NullAction _:
          break;
        case ClearAction _:
          canvas.drawRect(rect, erasePaint);
          break;
        case LineAction lineAction:
          final paint = Paint()..color = lineAction.color
          ..strokeWidth = 2;
          canvas.drawLine(lineAction.point1, lineAction.point2, paint);
          break;
        case StrokeAction strokeAction:
          final paint = Paint()..color = strokeAction.color
          ..strokeWidth = 2;
          for (int i = 0; i < strokeAction.points.length - 1; i++) {
            canvas.drawLine(strokeAction.points[i], strokeAction.points[i+1], paint);
          }
          break;
        case OvalAction ovalAction:
          final paint = Paint()..color = ovalAction.color
          ..strokeWidth = 2;
          canvas.drawOval(Rect.fromPoints(ovalAction.point1, ovalAction.point2), paint);
          break;
        default:
          throw UnimplementedError('Action not implemented: $action'); 
      }
  }

  // Determines whether the painting of this custom painter should be repainted.
  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return oldDelegate._drawing != _drawing;
  }
}
