import 'package:flutter/material.dart';
import 'package:places/domain/details.dart';
import 'package:places/res/colors.dart';

class SightDetail extends StatelessWidget {
  final SightDetails description;
  const SightDetail({this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 320,
        backgroundColor: appBarColor,
        flexibleSpace: Stack(
          children: [
            Container(
              child: Image.network(
                '${description.url}',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fitWidth,
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
            Positioned(
              top: 40,
              left: 15,
              child: AppBarBackButton(),
            ),
            Positioned(
              bottom: 1,
              left: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
                width: 150,
                height: 8,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text('${description.name}',
                    style: Theme.of(context).textTheme.headline2),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('${description.type}',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 30,
                    ),
                    Text('${description.workHours}',
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('${description.details}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.normal)),
                SizedBox(
                  height: 30,
                ),
                NavigationButton(),
                SizedBox(
                  height: 20,
                ),
                Divider(color: primaryColor2),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlanButton(),
                    SizedBox(
                      width: 30,
                    ),
                    FavoriteButton(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: lmBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Center(
          child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.keyboard_arrow_left),
      )),
    );
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          'ПОСТРОИТЬ МАРШРУТ',
          style: TextStyle(
            color: lmBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}

class PlanButton extends StatelessWidget {
  const PlanButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: planIcon),
          SizedBox(
            width: 5,
          ),
          Text('Запланировать',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.normal, color: planIcon))
        ],
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          Icon(Icons.favorite_border, color: Theme.of(context).iconTheme.color),
          SizedBox(
            width: 5,
          ),
          Text(
            'В Избранное',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
