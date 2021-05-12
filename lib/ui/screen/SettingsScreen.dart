import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;
  var switchText = 'Тёмная тема';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(settings),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$switchText',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.normal)),
                  Consumer<ThemeNotifier>(
                    builder: (context, notifier, child) => CupertinoSwitch(
                      value: notifier.darkTheme,
                      onChanged: (value) {
                        notifier.changeTheme();
                      },
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tutorial,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.normal)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info_outline, color: buttonColor),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ));
  }
}

class ThemeNotifier extends ChangeNotifier {
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
  }

  changeTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}
