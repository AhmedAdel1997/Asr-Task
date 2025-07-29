import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/src/config/language/locale_keys.g.dart';

class Validators {
  static String? validateEmpty(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? LocaleKeys.fillField;
    }
    return null;
  }

  static String? validatePassword(String? value, {String? message}) {
    if (value?.trim().isEmpty ?? true) {
      return message ?? LocaleKeys.passRequiredValidation.tr();
    } else if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value!)) {
      return message ??
          LocaleKeys
              .passwordMustContainLowercaseUppercaseNumbersAndSpecialCharacters
              .tr();
    }
    return null;
  }

  static String? validateEmail(String? value, {String? message}) {
    if (value?.trim().isEmpty ?? true) {
      return message ?? LocaleKeys.mailValidation.tr();
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.["
            r"a-zA-Z]+")
        .hasMatch(value!)) {
      return message ?? LocaleKeys.mailValidation.tr();
    }
    return null;
  }

  static String? validatePhone(
    String? value,
  ) {
    if (value?.trim().isEmpty ?? true) {
      return LocaleKeys.fillField;
    }
    //  else if (!RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]'
    //             r'{4,6}$)')
    //         .hasMatch(value!) ||
    //     value.length < 10)
    else if (!value!.startsWith('05') && value.length != 10) {
      return '${LocaleKeys.pleaseEnterAValidMobileNumberForExample}  05xxxx xxxx';
    }
    return null;
  }

  static String? validateIdNumber(
    String? value,
  ) {
    final regex = RegExp(r'^[12]');
    if (value?.trim().isEmpty ?? true) {
      return LocaleKeys.fillField;
    }
    // else if (!value!.startsWith('1') || !value.startsWith('2')) {
    else if (!regex.hasMatch(value!)) {
      return LocaleKeys.idNumberMustStartWith1Or2;
    } else if (value.length != 10) {
      return LocaleKeys.idnumberMustBe10Digits;
    }
    return null;
  }

  static String? validatePasswordConfirm(String? value, String? pass,
      {String? message}) {
    if (value?.trim().isEmpty ?? true) {
      return message ?? LocaleKeys.fillField.tr();
    } else if (value != pass) {
      return message ?? LocaleKeys.confirmValidation.tr();
    }
    return null;
  }

  static String? validateDropDown<T>(T? value, {String? message}) {
    if (value == null) {
      return message ?? LocaleKeys.fillField.tr();
    }
    return null;
  }
}
