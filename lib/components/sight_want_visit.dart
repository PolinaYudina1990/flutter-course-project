import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:places/ui/screen/sight_details.dart';

class FavoriteWishVisit extends StatelessWidget {
  final Place place;
  final VoidCallback onDelete;
  final VoidCallback onFilterChange;
  final List<Place> candidateDataList;

  const FavoriteWishVisit({
    Key key,
    this.place,
    this.onDelete,
    this.onFilterChange,
    this.candidateDataList,
  }) : super(key: key);
  static const double Height = 120;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Place>(
      builder: (
        BuildContext context,
        List<Place> candidateData,
        List<dynamic> rejectedData,
      ) {
        return LongPressDraggable(
          data: place,
          axis: Axis.vertical,
          feedback: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: sightCard(context),
          ),
          child: sightCard(context),
          childWhenDragging: const SizedBox.shrink(),
        );
      },
      onAccept: (data) {
        int targetIndex = 0;
        candidateDataList.forEach(
          (element) {
            if (element.id == place.id) {
              targetIndex = candidateDataList.indexOf(element);
            }
          },
        );
        int acceptedIndex = 0;
        candidateDataList.forEach(
          (element) {
            if (element.id == data.id) {
              acceptedIndex = candidateDataList.indexOf(element);
            }
          },
        );

        candidateDataList[targetIndex] = data;
        candidateDataList[acceptedIndex] = place;
        onFilterChange();
      },
    );
  }

  Widget sightCard(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 30),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SightDetail(sightId: place.id),
              ),
            );
          },
          child: Dismissible(
            background: const SizedBox.shrink(),
            secondaryBackground: deleteBackground(context),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              // sight.wantToVisit = !sight.wantToVisit;
              // sight.visited = !sight.visited;
              onDelete();
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          place.urls[0],
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      height: FavoriteWishVisit.Height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        place.placeType,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Positioned(
                      //!button share
                      top: 1,
                      right: 40,
                      child: IconButton(
                        icon:
                            const Icon(Icons.share, size: 28, color: iconColor),
                        onPressed: () {
                          print('button "share" pressed');
                        },
                      ),
                    ),
                    Positioned(
                      //!button close
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon:
                            const Icon(Icons.close, size: 30, color: iconColor),
                        onPressed: () {
                          // sight.wantToVisit = !sight.wantToVisit;
                          // sight.visited = !sight.visited;
                          // print(sight.wantToVisit);
                          onDelete();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: FavoriteWishVisit.Height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Запланировано на 12 окт.2020',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Text(
                      //   '${sight.workHours}',
                      //   style: Theme.of(context).textTheme.subtitle2,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteBackground(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: Colors.red,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 32,
                maxHeight: 240,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          delete,
                          height: 15,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          backgroundTitle,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
