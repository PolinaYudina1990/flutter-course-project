import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;
  String switchText = 'Тёмная тема';

  bool get darkTheme => _darkTheme;

  bool _darkTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(settings),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, right: 20, left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  switchText,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                Switch.adaptive(
                  value: _darkTheme,
                  activeColor: buttonColor,
                  onChanged: (isDark) {
                    setState(() {
                      _darkTheme = isDark;
                    });
                    context.read<SettingsInteractor>().changeTheme(isDark);
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tutorial,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline, color: buttonColor),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
