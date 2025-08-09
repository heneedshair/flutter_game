import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class UserTabWidget extends StatelessWidget {
  const UserTabWidget({super.key, required this.onUserTap});

  final VoidCallback onUserTap;

  @override
  Widget build(BuildContext context) {
    final lablelStyle = context.theme.text.labelLarge?.copyWith(color: context.theme.colors.secondaryFixedDim);

    return Row(
      spacing: 12,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: context.theme.colors.secondaryFixed),
          ),
          child: CircleAvatar(backgroundColor: context.theme.colors.secondary, minRadius: 20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Пользователь', style: context.theme.text.titleLarge),
            Row(
              children: [
                Text('lvl: 14,', style: lablelStyle),
                const SizedBox(width: 8),
                Text('15', style: lablelStyle),
                const Icon(Icons.monetization_on_outlined, size: 20),
              ],
            ),
          ],
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings_rounded)),
      ],
    );
  }
}
