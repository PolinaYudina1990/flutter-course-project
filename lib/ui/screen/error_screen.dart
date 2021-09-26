import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          errorScreen,
          color: lmsubtitle2Color,
        ),
        SizedBox(height: 24),
        Text(
          'Ошибка',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: lmsubtitle2Color),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 150,
          child: Text(
            'Что то пошло не так\nПопробуйте позже.',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
