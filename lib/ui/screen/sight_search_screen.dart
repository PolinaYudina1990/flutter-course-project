import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/redux/actions/search_actions.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/search_state.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:places/ui/screen/sight_details.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _queryText = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Sight> result = [];
  List founded = [];
  List listToDisplay;
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
        title: Text(
          titleSightListScreen,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: Platform.isAndroid
                ? const ClampingScrollPhysics()
                : const BouncingScrollPhysics(),
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
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: secondary1,
                          fontWeight: FontWeight.normal,
                        ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
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
                const SizedBox(height: 30),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: StoreConnector<AppState, SearchState>(
                    converter: (store) => store.state.searchState,
                    builder: (context, state) {
                      if (state is InitialSearchState) {
                        return _historyValues();
                      }

                      if (state is ResultSearchState) {
                        result.isEmpty ? _emptyScreen() : _searchResult();
                        return _searchResult();
                      }

                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onChangedSearch(String value) async {
    result = StoreProvider.of<AppState>(context)
        .dispatch(QueryChangedSearchAction(_queryText.text));
  }

  Widget _searchResult() {
    if (result.isNotEmpty) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              history.add(result[index].name);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SightDetail(sightId: result[index].id),
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
      padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Column(
        children: [
          const Icon(Icons.search, size: 70, color: secondary2),
          const SizedBox(
            height: 20,
          ),
          Text(
            emptyScreenText1,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontSize: 20,
                  color: secondary2,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            emptyScreenText2,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontSize: 17, color: secondary2),
            textAlign: TextAlign.center,
          ),
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
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: history.length,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 1),
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
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: secondary2,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: secondary2,
            );
          },
        ),
        const SizedBox(height: 30),
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
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class SearchCard extends StatelessWidget {
  final Sight sight;

  const SearchCard({
    @required this.sight,
    Key key,
  }) : super(key: key);

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
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    sight.name,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  sight.titleType,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 20),
        const Divider(
          indent: 80,
        ),
      ],
    );
  }
}
