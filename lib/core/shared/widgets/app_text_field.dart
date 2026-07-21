import 'package:flutter/material.dart';

enum AppTextFieldType { text, email, password, phone, search, multiline }

class AppTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final AppTextFieldType type;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.type = AppTextFieldType.text,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      obscureText: widget.type == AppTextFieldType.password ? _obscureText : false,
      keyboardType: _getKeyboardType(),
      maxLines: widget.type == AppTextFieldType.multiline ? 4 : 1,
      minLines: widget.type == AppTextFieldType.multiline ? 3 : 1,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon ?? _getDefaultPrefixIcon(),
        suffixIcon: widget.type == AppTextFieldType.password
            ? IconButton(
                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon,
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;
      case AppTextFieldType.phone:
        return TextInputType.phone;
      case AppTextFieldType.multiline:
        return TextInputType.multiline;
      case AppTextFieldType.search:
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }

  Widget? _getDefaultPrefixIcon() {
    switch (widget.type) {
      case AppTextFieldType.search:
        return const Icon(Icons.search);
      default:
        return null;
    }
  }
}
