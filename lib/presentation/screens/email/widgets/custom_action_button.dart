import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    this.onPressed,
    required this.iconData,
    required this.label,
  });

  final Function()? onPressed;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      iconAlignment: IconAlignment.start,
      onPressed: onPressed,
      icon: Flexible(child: Icon(iconData, color: Theme.of(context).primaryColor)),
      label: Text(
        label,
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
