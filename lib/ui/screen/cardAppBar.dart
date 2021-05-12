import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Size get preferredSize {
    return Size.fromHeight(210.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 70,
        left: 16,
        bottom: 16,
        right: 16,
      ),
      child: Text(
        'Список \nинтересных мест',
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
