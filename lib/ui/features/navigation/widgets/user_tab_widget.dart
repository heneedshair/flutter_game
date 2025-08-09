import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class UserTabWidget extends StatelessWidget {
  const UserTabWidget({super.key, required this.onUserTap});

  final VoidCallback onUserTap;

  @override
  Widget build(BuildContext context) {
    final lablelStyle = context.theme.text.labelLarge?.copyWith(
      color: context.theme.colors.secondaryFixedDim,
      height: 1.23,
    );

    return Row(
      children: [
        Ink(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => onUserTap(),
            child: Padding(
              padding: const EdgeInsets.all(3.5),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: context.theme.colors.onSecondary),
                    ),
                    child: CircleAvatar(backgroundColor: context.theme.colors.onSecondary, minRadius: 18),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Пользователь',
                        style: context.theme.text.titleMedium?.copyWith(
                          color: DefaultTextStyle.of(context).style.color,
                          fontSize: 20,
                          height: 1.23,
                        ),
                      ),
                      Text('lvl: 14,  \$15', style: lablelStyle),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(child: IconButton(onPressed: () {}, icon: const Icon(Icons.settings_rounded))),
      ],
    );
  }
}
