import 'package:drawing_with_undo/models/tools.dart';
import 'package:drawing_with_undo/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Palette extends StatelessWidget {
  const Palette(BuildContext context, {super.key});

  // Builds a ListView widget that contains a list of clickable elements to use to choose the tool and color to draw with.
  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) => ListView(
        scrollDirection: Axis.vertical,
        children: [
          const DrawerHeader(
            child: Text('Tools and Colors', style: TextStyle(color: Colors.black)),
          ),
          _buildToolButton(name: 'Line', icon: Icons.timeline, tool: Tools.line, provider: drawingProvider),
          _buildToolButton(name: 'Stroke', icon: Icons.brush, tool: Tools.stroke, provider: drawingProvider),
          _buildToolButton(name: 'Oval', icon: Icons.circle_outlined, tool: Tools.oval, provider: drawingProvider),
          const Divider(),
          _buildColorButton('Red', Colors.red, drawingProvider),
          _buildColorButton('Green', Colors.green, drawingProvider),
          _buildColorButton('Blue', Colors.blue, drawingProvider),
          _buildColorButton('Orange', Colors.orange, drawingProvider),
          _buildColorButton('Purple', Colors.purple, drawingProvider),
          _buildColorButton('Yellow', Colors.yellow, drawingProvider),
        ],
      ),
    );
  }

  // Builds a button for selecting a drawing tool.
  Widget _buildToolButton({required String name, required IconData icon, required Tools tool, required DrawingProvider provider}) {
    final selectedTool = provider.toolSelected;
    final isSelected = selectedTool == tool;
    return Semantics(
      label: isSelected ? 'Deselect $name' : 'Select $name',
      child: InkWell(
        onTap: () {
          if (isSelected) {
            provider.toolSelected = Tools.none;
          } else {
            provider.toolSelected = tool;
          }
        },
        child: ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(name, style: const TextStyle(color: Colors.black)),
          selected: isSelected,
          selectedTileColor: const Color.fromARGB(255, 238, 238, 238)
        ),
      ),
    );
  }

  // Builds a button for selecting a color.
  Widget _buildColorButton(String name, Color color,  DrawingProvider provider) {
    final selectedColor = provider.colorSelected;
    final isSelected = selectedColor == color;
    return Semantics(
      label: isSelected ? 'Deselect $name' : 'Select $name',
      child: InkWell(
        onTap: () {
          if (!isSelected) {
            provider.colorSelected = color;
          }
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            radius: 12,
          ),
          title: Text(name, style: const TextStyle(color: Colors.black)),
          selected: isSelected,
          selectedTileColor: const Color.fromARGB(255, 238, 238, 238)
        ),
      ),
    );
  }

}
