import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? hintStyle;
  final TextStyle? style;
  final String? labelText;
  final double fontSize;
  final String? initialValue;
   final String obscuringCharacter;
  final bool autoFocus;
  final bool mask;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? labelStyle;
  final Widget? prefixIcon;
  final Widget? decoration;
  final Widget? prefixStyle;
  final Widget? prefixIconColor;
  final Widget? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final bool isNormal;
    final AutovalidateMode autovalidateMode; // Set this to non-nullable

  final bool? enabled;
  final Widget? label; 
  final Color? suffixIconColor;
  const CustomTextFormField(
      {super.key,
       this.hintText,
      this.onChanged,
      this.initialValue,
      this.hintStyle,
      this.prefixIconColor,
      this.decoration,
      this.labelStyle,
      this.prefixIconConstraints,
      this.fontSize = 16,
      this.autoFocus = false,
          this.autovalidateMode = AutovalidateMode.disabled, // Default to disabled

      this.mask = false,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.inputFormatters,
      this.validator,
      this.prefixIcon,
      this.prefixStyle,
      this.suffixIcon,
      this.controller,
      this.maxLines,
      this.labelText,
      this.maxLength,
      this.isNormal = false,
      this.enabled, this.label, this.suffixIconColor, this.style, this.obscuringCharacter='*',  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
      style:const TextStyle(color: Colors.white),
        expands: false,
        autofocus: autoFocus,
        obscureText: mask,
        validator: validator,
        maxLength: maxLength,
        controller: controller,
        autocorrect: false,
        enabled: enabled,
                autovalidateMode: autovalidateMode, // Use the argument here

        keyboardType: keyboardType,
        cursorColor: Colors.white,
        textAlign: TextAlign.start,
        initialValue: initialValue,obscuringCharacter: obscuringCharacter,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: hasText
              ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
              : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          errorStyle: const TextStyle(fontSize: 10.0,height: 1.0),
          isDense: true,
           helperText: ' ', 
          isCollapsed: false,
          counterText: "",
          labelText: labelText,
          label: label,
          border: const OutlineInputBorder(),
          errorMaxLines: 2,
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          hintStyle:const TextStyle(color: Colors.white),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          prefixIcon: prefixIcon,
          prefixStyle: const TextStyle(
            color: Customcolors.decorationBlack,
          ),
          labelStyle: const TextStyle(color: Customcolors.decorationGrey),
          prefixIconColor: Customcolors.decorationBlack,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          errorBorder: const UnderlineInputBorder(
            borderSide:  BorderSide(color: Customcolors.decorationred),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Customcolors.decorationred),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}



class AccountTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final RichText label;
  final Widget suffixIcon;
  final bool readOnly;
  final Function()? onTap;

 const AccountTextField({super.key, 
    required this.controller,
    required this.onChanged,
    required this.label,
    this.suffixIcon = const SizedBox(),
    this.readOnly = false,
    this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AccountTextFieldState createState() => _AccountTextFieldState();
}

class _AccountTextFieldState extends State<AccountTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (text) {
        widget.onChanged(text);
      },
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: null,
        label: widget.label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        suffixIcon: widget.suffixIcon,
        
          errorBorder: const UnderlineInputBorder(
            borderSide:  BorderSide(color: Customcolors.decorationred),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Customcolors.decorationred),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
      ),
    );
  }
}


class CustomPriceTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? hintStyle;
  final TextStyle? style;
  final String? labelText;
  final double fontSize;
  final String? initialValue;
  final bool autoFocus;
  final bool mask;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? labelStyle;
  final Widget? prefixIcon;
  final Widget? decoration;
  final Widget? prefixStyle;
  final Widget? prefixIconColor;
  final Widget? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final bool isNormal;
  final bool? enabled;
  final Widget? label; 
      final AutovalidateMode autovalidateMode; // Set this to non-nullable

  final String obscuringCharacter;
  final Color? suffixIconColor;
  const CustomPriceTextFormField(
      {super.key,
       this.hintText,
      this.onChanged,
      this.initialValue,
      this.hintStyle,
      this.prefixIconColor,
      this.decoration,
      this.labelStyle,
      this.prefixIconConstraints,
      this.fontSize = 16,
                this.autovalidateMode = AutovalidateMode.onUserInteraction, // Default to disabled

      this.autoFocus = false,
      this.mask = false,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.inputFormatters,
      this.validator,
      this.prefixIcon,
      this.prefixStyle,
      this.suffixIcon,
      this.controller,
      this.maxLines,
      this.labelText,
      this.maxLength,
      this.isNormal = false,
      this.enabled =true, this.label, 
      this.suffixIconColor, 
      this.style, 
       this.obscuringCharacter='*',  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
       // style:   const TextStyle(color: Colors.black),
     style:  enabled ==true ? const TextStyle(color: Colors.black) :const TextStyle(color: Colors.grey),
        expands: false,
        autofocus: autoFocus,
        obscureText: mask,
        validator: validator,
        maxLength: maxLength,autovalidateMode: autovalidateMode, // Use the argument here
        controller: controller,
        autocorrect: false,
        enabled: enabled,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        obscuringCharacter: obscuringCharacter,
        textAlign: TextAlign.start,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: hasText
              ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
              : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          errorStyle: const TextStyle(fontSize: 10.0,height: 1.0, ),
          isDense: true,
          helperText: ' ', // Reserve space even if no error message
          isCollapsed: false,
          counterText: "",
          labelText: labelText,
          label: label,
          border: const OutlineInputBorder(),
          errorMaxLines: 2,
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          hintStyle:const TextStyle(color: Colors.white),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          prefixIcon: prefixIcon,
         // hintStyle:
          prefixStyle: const TextStyle(
            color: Customcolors.decorationBlack,
          ),
          labelStyle: enabled ==true ? const TextStyle(color: Customcolors.decorationGrey): const TextStyle(color: Colors.red),
          prefixIconColor: Customcolors.decorationBlack,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          errorBorder: const UnderlineInputBorder(
            borderSide:  BorderSide(color: Customcolors.decorationred),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Customcolors.decorationred),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          // hintStyle: RedoCustomTextStyle.regularTextFormHintStyle,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class CustomTypeTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? hintStyle;
  final TextStyle? style;
  final String? labelText;
  final double fontSize;
  final String? initialValue;
  final bool autoFocus;
  final bool readOnly;
  final bool mask;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
   final void Function()? onTap;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? labelStyle;
  final Widget? prefixIcon;
  final Widget? decoration;
  final Widget? prefixStyle;
  final Widget? prefixIconColor;
  final Widget? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final bool isNormal;
  final bool? enabled;
  final Widget? label; 
  final Color? suffixIconColor;
  const CustomTypeTextFormField(
      {super.key,
       this.hintText,
      this.onChanged,
      this.initialValue,
      this.hintStyle,
      this.prefixIconColor,
      this.decoration,
      this.labelStyle,
      this.prefixIconConstraints,
      this.fontSize = 16,
      this.autoFocus = false,
      this.mask = false,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.inputFormatters,
      this.validator,
      this.prefixIcon,
      this.prefixStyle,
      this.suffixIcon,
      this.controller,
      this.maxLines,
      this.labelText,
      this.maxLength,
      this.isNormal = false,
      this.enabled, this.label, this.suffixIconColor, this.style, this.onTap, required this.readOnly,  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
      style:const TextStyle(color: Colors.black),
        expands: false,
        readOnly: readOnly,
        onTap: onTap,
        autofocus: autoFocus,
        obscureText: mask,
        validator: validator,
        maxLength: maxLength,
        controller: controller,
        autocorrect: false,
        enabled: enabled,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: hasText
              ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
              : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          errorStyle: const TextStyle(fontSize: 10.0,height: 1.0),
          isDense: true,
           helperText: ' ', 
          isCollapsed: false,
          counterText: "",
          labelText: labelText,
          label: label,
          border: const OutlineInputBorder(),
          errorMaxLines: 2,
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          hintStyle:const TextStyle(color: Colors.white),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          prefixIcon: prefixIcon,
         // hintStyle:
          prefixStyle: const TextStyle(
            color: Customcolors.decorationBlack,
          ),
          labelStyle: const TextStyle(color: Customcolors.decorationGrey),
          prefixIconColor: Customcolors.decorationBlack,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          errorBorder: const UnderlineInputBorder(
            borderSide:  BorderSide(color: Customcolors.decorationred),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Customcolors.decorationred),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          // hintStyle: RedoCustomTextStyle.regularTextFormHintStyle,
        ),
        onChanged: onChanged,
      ),
    );
  }
}





class CreateCategoryTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? hintStyle;
  final TextStyle? style;
  final String? labelText;
  final double fontSize;
  final String? initialValue;
  final bool autoFocus;
  final bool mask;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
   final Function(String value)? onfieldsubmitted;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? labelStyle;
  final Widget? prefixIcon;
  final Widget? decoration;
  final Widget? prefixStyle;
  final Widget? prefixIconColor;
  final Widget? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final bool isNormal;
  final bool? enabled;
  final Widget? label; 
      final AutovalidateMode autovalidateMode; // Set this to non-nullable

  final String obscuringCharacter;
  final Color? suffixIconColor;
  const CreateCategoryTextFormField(
      {super.key,
       this.hintText,
      this.onChanged,
      this.onfieldsubmitted,
      this.initialValue,
      this.hintStyle,
      this.prefixIconColor,
      this.decoration,
      this.labelStyle,
      this.prefixIconConstraints,
      this.fontSize = 16,
      this.autovalidateMode = AutovalidateMode.onUserInteraction, // Default to disabled
      this.autoFocus = false,
      this.mask = false,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.inputFormatters,
      this.validator,
      this.prefixIcon,
      this.prefixStyle,
      this.suffixIcon,
      this.controller,
      this.maxLines,
      this.labelText,
      this.maxLength,
      this.isNormal = false,
      this.enabled =true, this.label, 
      this.suffixIconColor, 
      this.style, 
       this.obscuringCharacter='*',  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
       // style:   const TextStyle(color: Colors.black),
     style:  enabled ==true ? const TextStyle(color: Colors.black) :const TextStyle(color: Colors.grey),
        expands: false,
        autofocus: autoFocus,
        obscureText: mask,
        validator: validator,
        maxLength: maxLength,autovalidateMode: autovalidateMode, // Use the argument here
        controller: controller,
        autocorrect: false,
        enabled: enabled,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        obscuringCharacter: obscuringCharacter,
        textAlign: TextAlign.start,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: hasText
              ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
              : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          errorStyle: const TextStyle(fontSize: 10.0,height: 1.0, ),
          isDense: true,
          helperText: ' ', // Reserve space even if no error message
          isCollapsed: false,
          counterText: "",
          labelText: labelText,
          label: label,
          border: const OutlineInputBorder(),
          errorMaxLines: 2,
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          hintStyle:const TextStyle(color: Colors.white),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          prefixIcon: prefixIcon,
         // hintStyle:
          prefixStyle: const TextStyle(
            color: Customcolors.decorationBlack,
          ),
          labelStyle: enabled ==true ? const TextStyle(color: Customcolors.decorationGrey): const TextStyle(color: Colors.red),
          prefixIconColor: Customcolors.decorationBlack,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          errorBorder: const UnderlineInputBorder(
            borderSide:  BorderSide(color: Customcolors.decorationred),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Customcolors.decorationred),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          // hintStyle: RedoCustomTextStyle.regularTextFormHintStyle,
        ),
        onChanged: onChanged,
        onFieldSubmitted: onfieldsubmitted,
      ),
    );
  }
}



class CustomIngredientsTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? hintStyle;
  final TextStyle? style;
  final String? labelText;
  final double fontSize;
  final String? initialValue;
  final bool autoFocus;
  final bool mask;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? labelStyle;
  final Widget? prefixIcon;
  final Widget? decoration;
  final Widget? prefixStyle;
  final Widget? prefixIconColor;
  final Widget? prefixIconConstraints;
  final int? maxLines;
  final int? maxLength;
  final bool isNormal;
  final bool? enabled;
  final Widget? label; 
      final AutovalidateMode autovalidateMode; // Set this to non-nullable

  final String obscuringCharacter;
  final Color? suffixIconColor;
  const CustomIngredientsTextFormField(
      {super.key,
       this.hintText,
      this.onChanged,
      this.initialValue,
      this.hintStyle,
      this.prefixIconColor,
      this.decoration,
      this.labelStyle,
      this.prefixIconConstraints,
      this.fontSize = 16,
                this.autovalidateMode = AutovalidateMode.onUserInteraction, // Default to disabled

      this.autoFocus = false,
      this.mask = false,
      this.keyboardType = TextInputType.text,
      this.textCapitalization,
      this.inputFormatters,
      this.validator,
      this.prefixIcon,
      this.prefixStyle,
      this.suffixIcon,
      this.controller,
      this.maxLines,
      this.labelText,
      this.maxLength,
      this.isNormal = false,
      this.enabled =true, this.label, 
      this.suffixIconColor, 
      this.style, 
       this.obscuringCharacter='*',   });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
       // style:   const TextStyle(color: Colors.black),
     style:  enabled ==true ? const TextStyle(color: Colors.black) :const TextStyle(color: Colors.grey),
        expands: false,
        autofocus: autoFocus,
        obscureText: mask,
        validator: validator,
        maxLength: maxLength,autovalidateMode: autovalidateMode, // Use the argument here
        controller: controller,
        autocorrect: false,
        enabled: enabled,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        obscuringCharacter: obscuringCharacter,
        textAlign: TextAlign.start,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: hasText
              ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
              : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          errorStyle: const TextStyle(fontSize: 10.0,height: 1.0, ),
          isDense: true,
          helperText: ' ', // Reserve space even if no error message
          isCollapsed: false,
          counterText: "",
          labelText: labelText,
          label: label,
          border: const OutlineInputBorder(),
          errorMaxLines: 2,
          fillColor: Colors.transparent,
          filled: true,
          hintText: hintText,
          hintStyle:const TextStyle(color: Colors.white),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          prefixIcon: prefixIcon,
         // hintStyle:
          prefixStyle: const TextStyle(
            color: Customcolors.decorationBlack,
          ),
          labelStyle: enabled ==true ? const TextStyle(color: Customcolors.decorationGrey): const TextStyle(color: Colors.red),
          prefixIconColor: Customcolors.decorationBlack,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          errorBorder: const UnderlineInputBorder(
            borderSide:  BorderSide(color: Customcolors.decorationred),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Customcolors.decorationred),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Customcolors.decorationGrey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          // hintStyle: RedoCustomTextStyle.regularTextFormHintStyle,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
