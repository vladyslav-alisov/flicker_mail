import 'package:flutter/material.dart';

class CustomCircularAvatar extends StatelessWidget {
  final String name;

  const CustomCircularAvatar({super.key, required this.name});

  String getInitials(String name) {
    return (name.isNotEmpty ? name.substring(0, 2) : "UN").toUpperCase();
  }

  Color getColorFromString(String input) {
    final hash = input.hashCode;
    final hue = (hash % 360).toDouble();
    return HSLColor.fromAHSL(1.0, hue, 0.5, 0.5).toColor();
  }

  @override
  Widget build(BuildContext context) {
    String initials = getInitials(name);
    Color avatarColor = getColorFromString(name);

    return CircleAvatar(
      radius: 24,
      backgroundColor: avatarColor,
      child: Text(
        initials,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
