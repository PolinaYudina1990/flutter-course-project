import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';

import '../../mocks.dart';
import 'SelectCategoryScreen.dart';

class AddNewSight extends StatefulWidget {
  AddNewSight({Key key}) : super(key: key);

  @override
  _AddNewSightState createState() => _AddNewSightState();
}

class _AddNewSightState extends State<AddNewSight> {
  FocusNode categoryNode;
  FocusNode name;
  FocusNode latitude;
  FocusNode longitude;
  FocusNode description;

  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerLatitude = TextEditingController();
  TextEditingController _controllerLongitude = TextEditingController();
  TextEditingController _controllerDetails = TextEditingController();

  String selectedCat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 100,
          centerTitle: true,
          title: Text(titleAddSight),
          leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(actionAppBar,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: planIcon))),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _category(),
                SizedBox(height: 20),
                _name(),
                SizedBox(height: 20),
                _longLat(),
                SizedBox(height: 20),
                Text(showOnMap,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: buttonColor)),
                SizedBox(height: 20),
                _descr(),
                _createNewSightButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(categoryTitle,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontWeight: FontWeight.normal, color: planIcon)),
        SizedBox(height: 20),
        TextField(
          onTap: () async {
            _chooseSightCategory(context);
          },
          readOnly: true,
          focusNode: categoryNode,
          autofocus: true,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: buttonColor,
                  width: 2.0,
                ),
              ),
              hintText: selectedCat != null ? selectedCat : 'Не выбрано',
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.normal, color: planIcon),
              suffixIcon:
                  Icon(Icons.keyboard_arrow_right, color: primaryColor2)),
          textInputAction: TextInputAction.next,
          onChanged: (text) {
            categoryNode.unfocus();
            FocusScope.of(context).requestFocus(name);
          },
          controller: _controllerCategory,
        ),
      ],
    );
  }

  Widget _name() {
    return Column(
      children: [
        Text(nameTitle,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontWeight: FontWeight.normal, color: planIcon)),
        SizedBox(height: 20),
        TextField(
          focusNode: name,
          cursorColor: primaryColor2,
          cursorHeight: 25,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: buttonColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: buttonColor,
                width: 2.0,
              ),
            ),
          ),
          textInputAction: TextInputAction.next,
          onSubmitted: (text) {
            name.unfocus();
            FocusScope.of(context).requestFocus(latitude);
          },
          controller: _controllerTitle,
        ),
      ],
    );
  }

  Widget _longLat() {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(point1Title,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.normal, color: planIcon)),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  focusNode: latitude,
                  cursorColor: primaryColor2,
                  cursorHeight: 25,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: buttonColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: buttonColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (text) {
                    latitude.unfocus();
                    FocusScope.of(context).requestFocus(longitude);
                  },
                  controller: _controllerLatitude,
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(point2Title,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.normal, color: planIcon)),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  focusNode: longitude,
                  cursorColor: primaryColor2,
                  cursorHeight: 25,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: buttonColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: buttonColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (text) {
                    longitude.unfocus();
                    FocusScope.of(context).requestFocus(description);
                  },
                  controller: _controllerLongitude,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descr() {
    return Column(
      children: [
        Text(descriptionTitle,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontWeight: FontWeight.normal, color: planIcon)),
        SizedBox(height: 20),
        TextField(
          focusNode: description,
          minLines: 4,
          maxLines: null,
          cursorColor: primaryColor2,
          cursorHeight: 25,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: buttonColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: buttonColor,
                width: 2.0,
              ),
            ),
          ),
          textInputAction: TextInputAction.done,
          onSubmitted: (value) => FocusManager.instance.primaryFocus.unfocus(),
          controller: _controllerDetails,
        ),
      ],
    );
  }

  void _chooseSightCategory(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SelectCategoryScreen()));
    setState(() {
      selectedCat = result;
    });
  }

  bool _checkIfClear() {
    return _controllerCategory != null &&
        _controllerTitle.text.isNotEmpty &&
        _controllerLatitude.text.isNotEmpty &&
        _controllerLongitude.text.isNotEmpty &&
        _controllerDetails.text.isNotEmpty;
  }

  Widget _createNewSightButton() {
    return TextButton(
      onPressed: _checkIfClear()
          ? () {
              Sight newSight = Sight(
                name: _controllerTitle.text,
                coordinatePoint: CoordinatePoint(
                  double.tryParse(_controllerLatitude.text),
                  double.tryParse(_controllerLongitude.text),
                ),
                url: '',
                details: _controllerDetails.text,
                titleType: selectedCat.toString(),
                workHours: 'закрыто до 09:00',
              );
              mocks.add(newSight);
              Navigator.pop(context);
            }
          : null,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
            color: _checkIfClear() ? buttonColor : planIcon,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
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