import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_eats_clone/presentation/widgets/common/custom_text.dart';
import 'package:uber_eats_clone/presentation/widgets/common/gap_widget.dart';

class PersonalInfoTextfield extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? Function(String?)? onSaved;
  final String text, labelText;
  final bool autofocus;
  final FocusNode? focusNode;
  const PersonalInfoTextfield(
      {super.key,
      this.validator,
      this.onSaved,
      required this.text,
      required this.labelText,
      this.controller,
      this.autofocus = false,this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          fontSize: 20,
        ),
        const GapWidget(size: -10),
        TextFormField(
          autofocus: autofocus,
          focusNode: focusNode,
          controller: controller,inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),],
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
