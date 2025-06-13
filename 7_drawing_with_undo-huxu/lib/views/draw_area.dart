import 'package:drawing_with_undo/models/draw_actions/draw_actions.dart';
import 'package:drawing_with_undo/models/tools.dart';
import 'package:drawing_with_undo/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawing_painter.dart';

class DrawArea extends StatelessWidget {
  const DrawArea({super.key, required this.width, required this.height});

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) {
        return CustomPaint(
          size: Size(width, height),
          painter: DrawingPainter(drawingProvider),
          child: GestureDetector(
              onPanStart: (details) => _panStart(details, drawingProvider),
              onPanUpdate: (details) => _panUpdate(details, drawingProvider),
              onPanEnd: (details) => _panEnd(details, drawingProvider),
              child: Container(
                  width: width,
                  height: height,
                  color: Colors.transparent,
                  child: unchangingChild)),
        );
      },
    );
  }

  // Handles the start of a pan/drawing action.
  void _panStart(DragStartDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        drawingProvider.pendingAction = NullAction();
        break;
      case Tools.line:
        drawingProvider.pendingAction = LineAction(
          details.localPosition,
          details.localPosition,
          drawingProvider.colorSelected
        );
        break;
      case Tools.stroke:
        final List<Offset> points = [];
        points.add(details.localPosition);
        drawingProvider.pendingAction = StrokeAction(
          points,
          drawingProvider.colorSelected
        );
        break;
      case Tools.oval:
        drawingProvider.pendingAction = OvalAction(
          details.localPosition, details.localPosition,
          drawingProvider.colorSelected
        );
        break;
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }

  // Handles the update of a pan/drawing action.
  void _panUpdate(DragUpdateDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        break;
      case Tools.line:
        final pendingAction = drawingProvider.pendingAction as LineAction;
        drawingProvider.pendingAction = LineAction(
          pendingAction.point1,
          details.localPosition,
          pendingAction.color
        );
        break;
      case Tools.stroke:
        final pendingAction = drawingProvider.pendingAction as StrokeAction;
        final List<Offset> updatedPoints = List.from(pendingAction.points)..add(details.localPosition);
        drawingProvider.pendingAction = StrokeAction(
          updatedPoints,
          pendingAction.color
        );
        break;
      case Tools.oval:
        final pendingAction = drawingProvider.pendingAction as OvalAction;
        drawingProvider.pendingAction = OvalAction(
          pendingAction.point1, details.localPosition, pendingAction.color
        );
        break;
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }

  // Handles the end of a pan/drawing action.
  void _panEnd(DragEndDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;
    final pendingAction = drawingProvider.pendingAction;

    if (currentTool != Tools.none && pendingAction != NullAction()) {
      drawingProvider.add(pendingAction);
      drawingProvider.pendingAction = NullAction();
    }
  }
}
