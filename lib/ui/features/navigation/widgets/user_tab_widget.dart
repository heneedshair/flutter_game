import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class UserTabWidget extends StatelessWidget {
  const UserTabWidget({super.key, required this.onUserTap});

  final VoidCallback onUserTap;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.theme.text;
    final colors = context.theme.colors;

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
                  /// [Avatar]
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: colors.onSecondary),
                    ),
                    child: CircleAvatar(backgroundColor: colors.onSecondary, minRadius: 18),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// [UserName]
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'Пользователь',
                          style: context.theme.text.titleMedium?.copyWith(
                            color: colors.onSecondary,
                            fontSize: 20,
                            height: 1,
                          ),
                        ),
                      ),

                      /// [User Info]
                      Ink(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                        decoration: ShapeDecoration(shape: const StadiumBorder(), color: colors.secondaryFixedDim),
                        child: Text(
                          'lvl: 14,  \$15',
                          style: textStyles.titleSmall?.copyWith(color: context.theme.colors.onSecondary, height: 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
