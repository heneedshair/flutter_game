import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/ui/theme/theme.dart';

enum ButtonType { primary, secondary }

class Button extends StatefulWidget {
  const Button._({
    required this.text,
    this.isEnabled = true,
    this.onTap,
    this.onAsyncTap,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 30,
    this.isExpanded = false,
    this.isOutlined = false,
    required this.type,
    this.spacing = 8,
  }) : assert(
         (onTap != null && onAsyncTap == null) || (onTap == null && onAsyncTap != null),
         'Required only 1 onTap method',
       );

  final bool isEnabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isExpanded;
  final double borderRadius;
  final bool isOutlined;
  final ButtonType type;
  final String text;
  final VoidCallback? onTap;
  final AsyncCallback? onAsyncTap;
  final double spacing;

  factory Button.filledPrimary({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool isExpanded = false,
    double spacing = 8,
  }) => Button._(
    text: text,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    type: ButtonType.primary,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    spacing: spacing,
  );

  factory Button.filledSecondary({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool isExpanded = false,
    double spacing = 8,
  }) => Button._(
    text: text,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    type: ButtonType.secondary,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    spacing: spacing,
  );

  factory Button.filledPrimaryAccent({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool isExpanded = false,
    double spacing = 8,
  }) => Button._(
    text: text,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    type: ButtonType.primary,
    borderRadius: 0,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    spacing: spacing,
  );

  factory Button.outlinedPrimary({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool isExpanded = false,
    double spacing = 8,
  }) => Button._(
    text: text,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    prefixIcon: prefixIcon,
    suffixIcon: prefixIcon,
    type: ButtonType.primary,
    isOutlined: true,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    spacing: spacing,
  );

  factory Button.outlinedPrimaryAccent({
    required String text,
    bool isEnabled = true,
    VoidCallback? onTap,
    AsyncCallback? onAsyncTap,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool isExpanded = false,
    double spacing = 8,
  }) => Button._(
    text: text,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    type: ButtonType.primary,
    isOutlined: true,
    borderRadius: 0,
    onTap: onTap,
    onAsyncTap: onAsyncTap,
    spacing: spacing,
  );

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  late Color mainColor;
  late Color extraColor;
  late Color backgroundColor;
  late Color foregroundColor;

  bool isLoading = false;

  @override
  void didChangeDependencies() {
    late final Color materialColor;
    late final Color onMaterialColor;
    switch (widget.type) {
      case ButtonType.primary:
        materialColor = context.theme.colors.primary;
        onMaterialColor = context.theme.colors.onPrimary;
        break;
      case ButtonType.secondary:
        materialColor = context.theme.colors.secondary;
        onMaterialColor = context.theme.colors.onSecondary;
    }
    mainColor = widget.isOutlined ? onMaterialColor : materialColor;
    extraColor = widget.isOutlined ? materialColor : onMaterialColor;
    backgroundColor = mainColor;
    foregroundColor = extraColor;
    super.didChangeDependencies();
  }

  void onTapDown() {
    if (!widget.isEnabled || isLoading) return;
    foregroundColor = widget.isOutlined ? extraColor : mainColor;
    backgroundColor = widget.isOutlined ? extraColor.withOpacity(0.07) : extraColor;
    setState(() {});
  }

  void onTapUp() {
    if (!widget.isEnabled || isLoading) return;
    foregroundColor = extraColor;
    backgroundColor = mainColor;
    setState(() {});
  }

  Future<void> onAsyncTap() async {
    setState(() => isLoading = true);
    await widget.onAsyncTap!();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color: widget.isOutlined ? backgroundColor : foregroundColor,
      ),
      child: Opacity(
        opacity: widget.isEnabled ? 1 : 0.63,
        child: GestureDetector(
          onTapDown: (_) => onTapDown(),
          onTapUp: (_) => onTapUp(),
          onTapCancel: () => onTapUp(),
          onTap:
              !widget.isEnabled || isLoading
                  ? null
                  : widget.onTap != null
                  ? () => widget.onTap!()
                  : () => onAsyncTap(),
          child: AnimatedContainer(
            duration: Duration(milliseconds: widget.isOutlined ? 0 : 250),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              border: Border.all(width: 2, style: BorderStyle.solid, color: widget.isOutlined ? extraColor : mainColor),
              color: backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Stack(
              children: [
                Opacity(
                  opacity: isLoading ? 0 : 1,
                  child: Row(
                    mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.prefixIcon != null) ...[
                        Icon(widget.prefixIcon, color: foregroundColor),
                        SizedBox(width: widget.spacing),
                      ],
                      Text(widget.text, style: context.theme.text.titleSmall?.copyWith(color: foregroundColor)),
                      if (widget.suffixIcon != null) ...[
                        SizedBox(width: widget.spacing),
                        Icon(widget.suffixIcon, color: foregroundColor),
                      ],
                    ],
                  ),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: Center(
                      child: SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: foregroundColor),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CounterButton extends StatefulWidget {
  const CounterButton._({
    required this.value,
    this.isEnabled = true,
    this.isOutlined = false,
    this.isExpanded = false,
    this.onAddTap,
    this.onAddAsyncTap,
    this.onRemoveTap,
    this.onRemoveAsyncTap,
  }) : assert(
         (onAddTap != null && onRemoveTap != null && onAddAsyncTap == null && onRemoveAsyncTap == null) ||
             (onAddAsyncTap != null && onRemoveAsyncTap != null && onAddTap == null && onRemoveTap == null),
         'Required only 1 type of methods (sync or async).',
       );

  final int value;
  final bool isEnabled;
  final bool isOutlined;
  final bool isExpanded;
  final VoidCallback? onAddTap;
  final AsyncCallback? onAddAsyncTap;
  final VoidCallback? onRemoveTap;
  final AsyncCallback? onRemoveAsyncTap;

  factory CounterButton.outlined({
    required int value,
    bool isEnabled = true,
    bool isExpanded = false,
    VoidCallback? onAddTap,
    AsyncCallback? onAddAsyncTap,
    VoidCallback? onRemoveTap,
    AsyncCallback? onRemoveAsyncTap,
  }) => CounterButton._(
    value: value,
    isEnabled: isEnabled,
    isExpanded: isExpanded,
    onAddTap: onAddTap,
    onAddAsyncTap: onAddAsyncTap,
    onRemoveTap: onRemoveTap,
    onRemoveAsyncTap: onRemoveAsyncTap,
  );

  factory CounterButton.filled({
    required int value,
    bool isEnabled = true,
    bool isExpanded = false,
    VoidCallback? onAddTap,
    AsyncCallback? onAddAsyncTap,
    VoidCallback? onRemoveTap,
    AsyncCallback? onRemoveAsyncTap,
  }) => CounterButton._(
    value: value,
    isEnabled: isEnabled,
    isOutlined: true,
    isExpanded: isExpanded,
    onAddTap: onAddTap,
    onAddAsyncTap: onAddAsyncTap,
    onRemoveTap: onRemoveTap,
    onRemoveAsyncTap: onRemoveAsyncTap,
  );

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

enum Operation { add, remove }

class _CounterButtonState extends State<CounterButton> {
  bool isLoading = false;

  void onAsyncTap(Operation operationType) async {
    if (isLoading || !widget.isEnabled) return;
    setState(() => isLoading = true);
    await (operationType == Operation.add ? widget.onAddAsyncTap!() : widget.onRemoveAsyncTap!());
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isEnabled ? 1 : 0.63,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: widget.isOutlined ? context.theme.colors.onSurface : context.theme.colors.primary,
          ),
          borderRadius: BorderRadius.circular(30),
          color: widget.isOutlined ? context.theme.colors.onSurface : context.theme.colors.onPrimary,
        ),
        child: Row(
          mainAxisSize: widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap:
                  (!widget.isEnabled || isLoading)
                      ? null
                      : widget.onRemoveTap != null
                      ? () => widget.onRemoveTap!()
                      : () => onAsyncTap(Operation.remove),
              child: Icon(Icons.remove, color: context.theme.colors.primary, size: 20),
            ),
            SizedBox(
              height: (context.theme.text.titleMedium?.fontSize ?? 10) * 1.5,
              width: 46,
              child: Center(
                child:
                    isLoading
                        ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text(
                          widget.value.toString(),
                          style: context.theme.text.titleMedium?.copyWith(color: context.theme.colors.inverseSurface),
                        ),
              ),
            ),
            GestureDetector(
              onTap:
                  (!widget.isEnabled || isLoading)
                      ? null
                      : widget.onAddTap != null
                      ? () => widget.onAddTap!()
                      : () => onAsyncTap(Operation.add),
              child: Icon(Icons.add, color: context.theme.colors.primary, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class VariantButton extends StatelessWidget {
  const VariantButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.63,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: isSelected ? context.theme.colors.primary : context.theme.colors.onSurface,
            ),
            borderRadius: BorderRadius.circular(30),
            color: context.theme.colors.onSurface,
          ),
          child: Opacity(
            opacity: isEnabled ? 1 : 0.63,
            child: Text(text, style: context.theme.text.titleSmall?.copyWith(color: context.theme.colors.primary)),
          ),
        ),
      ),
    );
  }
}
