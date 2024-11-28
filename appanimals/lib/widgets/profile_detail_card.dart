import 'package:flutter/material.dart';

class ProfileDetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color textColor;
  final Color iconColor;
  final Color cardColor;

  const ProfileDetailCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
    required this.iconColor,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLightTheme ? const Color(0xFFC0BABA) : const Color(0xFF3D3C3C),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '$label: $value',
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
