import 'package:flutter/material.dart';
import 'package:places/domain/categories.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';

class SelectCategoryScreen extends StatefulWidget {
  static const routeName = '/categorySelectionScreen';
  const SelectCategoryScreen({Key key}) : super(key: key);

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  String selectedCategoryName;
  int selectedCategoryIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        title: const Text(titleAddCategory),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: categoryList(),
        ),
      ),
    );
  }

  List<Widget> categoryList() {
    final List<Widget> widgets = [];
    for (FilterType category in categories) {
      widgets.add(_listOfCategories(category));
    }
    widgets.add(_buildCreateButton());
    return widgets;
  }

  Widget _listOfCategories(FilterType category) {
    return Column(
      children: [
        ListTile(
          dense: true,
          selected: category.title == selectedCategoryName,
          selectedTileColor: Colors.transparent,
          title: Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.normal),
          ),
          trailing: category.title == selectedCategoryName
              ? const Icon(
                  Icons.done,
                  color: buttonColor,
                )
              : null,
          onTap: () {
            setState(() {
              selectedCategoryName = category.title;
            });
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(
            thickness: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return TextButton(
      onPressed: selectedCategoryName != null
          ? () {
              Navigator.pop(context, selectedCategoryName);
            }
          : null,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          color: selectedCategoryName != null ? buttonColor : planIcon,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: const Text(
          buttonSave,
          style: TextStyle(
            color: iconColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
