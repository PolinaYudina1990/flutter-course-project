import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import '../../mocks.dart';
import 'sight_details.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _queryText = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<Sight> result = [];
  List founded = [];
  var listToDisplay;
  String queryText;
  bool _load = false;

  @override
  Widget build(BuildContext context) {
    _focusNode.requestFocus();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(titleSightListScreen,
            style: Theme.of(context).textTheme.headline3),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: Platform.isAndroid
                ? ClampingScrollPhysics()
                : BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _queryText,
                    cursorColor: primaryColor2,
                    cursorHeight: 24,
                    cursorWidth: 1,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: secondary1, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: planIcon,
                      ),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          closeIcon,
                          width: 20,
                          color: primaryColor2,
                        ),
                        onPressed: () {
                          _queryText.clear();
                          _onChangedSearch('');
                          //! ClearButton
                        },
                      ),
                      border: InputBorder.none,
                      hintText: hintText,
                    ),
                    onChanged: _onChangedSearch,
                    onSubmitted: (value) {
                      setState(() {
                        history.add(value);
                        print(history);
                        _focusNode.unfocus();
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: _queryText.text.isEmpty
                      ? _historyValues()
                      : _load
                          ? CircularProgressIndicator()
                          : result.isEmpty
                              ? _emptyScreen()
                              : _searchResult(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onChangedSearch(String value) async {
    setState(() {
      _load = true;
    });
    founded = mocks
        .where(
            (sight) => sight.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _load = false;
      result = founded;
    });
  }

  Widget _searchResult() {
    if (result.length > 0) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              history.add(result[index].name);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SightDetail(
                    sight: result[index],
                  ),
                ),
              );
            },
            child: SearchCard(
              sight: result[index],
            ),
          );
        },
      );
    } else {
      return _emptyScreen();
    }
  }

  Widget _emptyScreen() {
    return Container(
      padding: EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 70, color: secondary2),
          SizedBox(
            height: 20,
          ),
          Text(emptyScreenText1,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 20, color: secondary2)),
          SizedBox(
            height: 10,
          ),
          Text(emptyScreenText2,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 17, color: secondary2),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _historyValues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          historyScreenText1,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        ListView.separated(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: history.length,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
              title: Text(
                history[index],
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              trailing: InkWell(
                  onTap: () {
                    setState(() {
                      history.removeAt(index);
                    });
                  },
                  child: Icon(Icons.close, size: 20, color: secondary2)),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: secondary2,
            );
          },
        ),
        SizedBox(height: 30),
        InkWell(
          onTap: () {
            setState(() {
              history.clear();
            });
          },
          child: history.isNotEmpty
              ? Text(
                  historyScreenText2,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: buttonColor),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}

class SearchCard extends StatelessWidget {
  final Sight sight;

  SearchCard({Key key, @required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 56,
              width: 56,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Image.network(
                  sight.urlImages[0],
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 20),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      '${sight.name}',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${sight.titleType}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(width: 20),
        Divider(
          indent: 80,
        ),
      ],
    );
  }
}
