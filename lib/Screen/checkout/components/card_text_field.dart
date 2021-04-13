import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  CardTextField(
      {this.title,
      this.bold = false,
      this.hint,
      this.textInputType,
      this.inputFormatters,
      this.validator,
      this.maxLenght,
      this.textAlign = TextAlign.start});

  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final int maxLenght;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: '',
      validator: validator,
      builder: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    if (state.hasError)
                      Expanded(
                        child: const Text(
                          'Invalido',
                          style: TextStyle(color: Colors.red, fontSize: 9),
                        ),
                      )
                  ],
                ),
              TextFormField(
                style: TextStyle(
                    color: title == null && state.hasError
                        ? Colors.red
                        : Colors.white,
                    fontWeight: bold ? FontWeight.bold : FontWeight.w500),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                      color: title == null && state.hasError
                          ? Colors.redAccent
                          : Colors.white.withAlpha(100)),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  counterText: '',
                ),
                keyboardType: textInputType,
                inputFormatters: inputFormatters,
                onChanged: (text) {
                  state.didChange(text);
                },
                maxLength: maxLenght,
                textAlign: textAlign,
              )
            ],
          ),
        );
      },
    );
  }
}
