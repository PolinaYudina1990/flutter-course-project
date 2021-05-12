import 'package:flutter/material.dart';

TextStyle _text = const TextStyle(
  fontStyle: FontStyle.normal,
);

final titleText1 = _text.copyWith(fontSize: 40, fontWeight: FontWeight.bold);
final titleText2 = _text.copyWith(fontSize: 25, fontWeight: FontWeight.bold);

final textReg14 = _text.copyWith(fontSize: 14);

final textReg15 = _text.copyWith(fontSize: 15, fontWeight: FontWeight.w400);
final textReg15bold = _text.copyWith(fontSize: 15, fontWeight: FontWeight.w700);

final textReg16bold = _text.copyWith(fontSize: 16, fontWeight: FontWeight.w600);

final textMedbold = _text.copyWith(
    fontSize: 27, fontWeight: FontWeight.bold, letterSpacing: 0.1);
