import 'package:flutter/material.dart';

import '../models/draw_actions/draw_actions.dart';
import '../models/drawing.dart';
import '../models/tools.dart';

class DrawingProvider extends ChangeNotifier {
  Drawing? _drawing; // used to create a cached drawing via replay of past actions
  DrawAction _pendingAction = NullAction();
  Tools _toolSelected = Tools.none;
  Color _colorSelected = Colors.blue;

  final List<DrawAction> _pastActions;
  final List<DrawAction> _futureActions;

  final double width;
  final double height;

  DrawingProvider({required this.width, required this.height})
      : _pastActions = [],
        _futureActions = [];

  Drawing get drawing {
    if (_drawing == null) {
      _createCachedDrawing();
    }
    return _drawing!;
  }

  // Sets the pending action to be performed. Calls invalidateAndNotify.
  set pendingAction(DrawAction action) {
    _pendingAction = action;
    _invalidateAndNotify();
  }

  DrawAction get pendingAction => _pendingAction;

  // Sets the currently selected drawing tool. Calls invalidateAndNotify.
  set toolSelected(Tools aTool) {
    _toolSelected = aTool;
    _invalidateAndNotify();
  }

  Tools get toolSelected => _toolSelected;

  // Sets the currently selected drawing color. Calls invalidateAndNotify.
  set colorSelected(Color color) {
    _colorSelected = color;
    _invalidateAndNotify();
  }
  Color get colorSelected => _colorSelected;

  // Creates a new cached drawing using either all the past action or the past actions since the last ClearAction.
  _createCachedDrawing() {
    _drawing = Drawing(_pastActions, width: width, height: height);
  }

  // Invalidates the cached drawing and notifies the listeners.
  _invalidateAndNotify() {
    _drawing = null;
    notifyListeners();
  }

  // Adds a new draw action to the list of past actions. Calls invalidateAndNotify.
  add(DrawAction action) {
    _pastActions.add(action);
    _invalidateAndNotify();
  }

  // Undoes the last draw action performed. Calls invalidateAndNotify.
  undo() {
    if (_pastActions.isNotEmpty) {
      final lastAction = _pastActions.removeLast();
      _futureActions.add(lastAction);
      _invalidateAndNotify();
    }
  }

  // Redoes the last draw action performed. Calls invalidateAndNotify.
  redo() {
    if (_futureActions.isNotEmpty) {
      final nextAction = _futureActions.removeLast();
      _pastActions.add(nextAction);
      _invalidateAndNotify();
    }
  }

  // Clears drawing. Calls invalidateAndNotify.
  clear() {
    add(ClearAction());
  }
}
