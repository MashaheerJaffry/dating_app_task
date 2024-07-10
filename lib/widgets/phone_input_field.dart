import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:simply_poem/utils/constants/style_constants.dart';

import '../utils/constants/pallete.dart';

class PhoneNumberInput extends StatefulWidget {
  final Function(String) onPhoneNumberChanged;

  PhoneNumberInput({required this.onPhoneNumberChanged});

  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  PhoneNumber number = PhoneNumber(isoCode: 'US');

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      textStyle: StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
      selectorTextStyle:
          StyleConstants.headerTextStyle.copyWith(color: Pallete.black),
      onInputChanged: (PhoneNumber number) {
        widget.onPhoneNumberChanged(number.phoneNumber ?? '');
      },
      onInputValidated: (bool isValid) {
        print('Is phone number valid: $isValid');
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      initialValue: number,
      textFieldController: TextEditingController(),
      formatInput: false,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputDecoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Phone Number',
      ),
    );
  }
}
