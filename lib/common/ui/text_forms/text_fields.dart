import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game/ui/theme/theme.dart';

class TextForm extends StatefulWidget {
  const TextForm({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.labelText,
    this.borderRadius = 20,
    this.isEnabled = true,
    this.maxLength = 500,
    this.maxLines = 1,
    this.icon,
    this.prefixIcon,
    this.prefixText,
    this.checkValidation,
    this.fillColor,
    this.isFilled,
    this.keyboardType,
    this.focusNode,
    this.secondFocusNode,
    this.inputFormatters,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final String? Function(String value)? validator;
  final Function(bool isValid)? checkValidation;
  final double borderRadius;
  final int maxLength;
  final int maxLines;
  final bool isEnabled;
  final Color? fillColor;
  final bool? isFilled;
  final IconData? icon;
  final IconData? prefixIcon;
  final String? prefixText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final FocusNode? secondFocusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  String? errorText;

  bool _isWasUsed = false;

  void validate() {
    if (widget.validator != null) errorText = widget.validator!(widget.controller.text);
    setState(() {});

    if (widget.checkValidation != null) widget.checkValidation!(errorText == null);
  }

  void clearError() => setState(() => errorText = null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(
              widget.labelText!,
              style: context.theme.text.titleMedium,
            ),
          ),
        TextField(
          minLines: 1,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          enabled: widget.isEnabled,
          controller: widget.controller,
          onSubmitted: (_) => validate(),
          onEditingComplete: () {
            validate();
            if (widget.secondFocusNode != null && widget.secondFocusNode!.canRequestFocus) {
              widget.secondFocusNode!.requestFocus();
            }
          },
          onTap: () => _isWasUsed = true,
          scrollPhysics: const ClampingScrollPhysics(),
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onTapUpOutside: (_) {
            if (_isWasUsed) validate();
          },
          onTapOutside: (_) {
            validate();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onChanged: (v) {
            clearError();
            if (widget.onChanged != null) widget.onChanged!(v);
          },
          style: context.theme.text.titleSmall,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            floatingLabelStyle: context.theme.text.titleSmall?.copyWith(
              fontSize: 16,
              color: context.theme.colors.primary,
            ),
            fillColor: widget.fillColor,
            filled: widget.isFilled,
            counterText: '',
            prefixText: widget.prefixText,
            prefixStyle: context.theme.text.titleSmall,
            icon: widget.icon != null ? Icon(widget.icon) : null,
            iconColor: widget.isEnabled ? context.theme.colors.primary : context.theme.colors.primary.withOpacity(0.63),
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            prefixIconColor:
                widget.isEnabled ? context.theme.colors.primary : context.theme.colors.primary.withOpacity(0.63),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            labelText: widget.hintText,
            labelStyle: context.theme.text.bodyLarge,
            errorText: errorText,
            errorStyle: context.theme.text.bodyMedium?.copyWith(
              color: context.theme.colors.error,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.isEnabled ? context.theme.colors.primary : context.theme.colors.primary.withOpacity(0.63),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.isEnabled ? context.theme.colors.primary : context.theme.colors.primary.withOpacity(0.63),
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: context.theme.colors.error,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: context.theme.colors.error,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.isEnabled ? context.theme.colors.primary : context.theme.colors.primary.withOpacity(0.63),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
