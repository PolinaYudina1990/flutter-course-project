import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/text_styles.dart';

import '../../mocks.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: true,
          title: Text(
            'Избранное',
            style: textMedium20,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30)),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.grey[600],
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF3B3E6B)),
                    tabs: [
                      Tab(
                        child: Text(
                          'Хочу посетить',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Посещенные места',
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            FavoriteWishVisit(
              sight: mocks[1],
            ),
            FavoriteVisited(
              sight: mocks[0],
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteWishVisit extends StatelessWidget {
  final Sight sight;

  const FavoriteWishVisit({
    Key key,
    @required this.sight,
  }) : super(key: key);
  static const double Height = 120;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                  ),
                  child: Image.network(
                    '${sight.url}',
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
                height: Height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    '${sight.type}',
                    style: textReg14,
                  )),
              Positioned(
                //!button calendar plan
                top: 16,
                right: 50,
                child: Icon(Icons.date_range, size: 28, color: backgroundColor),
              ),
              Positioned(
                //!button close
                top: 16,
                right: 16,
                child: Icon(Icons.close, size: 30, color: backgroundColor),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: boxDescription,
              borderRadius: const BorderRadius.only(
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: Height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${sight.name}',
                  maxLines: 2,
                  style: textReg16Vis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Запланировано на 12 окт.2020',
                  style: textReg15green,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${sight.workHours}',
                  style: textReg15desc,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteVisited extends StatelessWidget {
  final Sight sight;

  const FavoriteVisited({
    Key key,
    @required this.sight,
  }) : super(key: key);
  static const double Height = 120;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                  ),
                  child: Image.network(
                    '${sight.url}',
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
                height: Height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    '${sight.type}',
                    style: textReg14,
                  )),
              Positioned(
                //!button share
                top: 16,
                right: 50,
                child: Icon(Icons.share, size: 28, color: backgroundColor),
              ),
              Positioned(
                //!button close
                top: 16,
                right: 16,
                child: Icon(Icons.close, size: 30, color: backgroundColor),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: boxDescription,
              borderRadius: const BorderRadius.only(
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: Height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${sight.name}',
                  maxLines: 2,
                  style: textReg16Vis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Цель достигнута 12 окт. 2020',
                  style: textReg15desc,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${sight.workHours}',
                  style: textReg15desc,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
