import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:places/ui/screen/sight_details.dart';

class FavoriteVisited extends StatelessWidget {
  final Sight sight;
  final VoidCallback onDelete;
  final VoidCallback onFilterChange;
  final VoidCallback isDissmissed;

  const FavoriteVisited(
      {Key key,
      this.sight,
      this.onDelete,
      this.onFilterChange,
      this.isDissmissed});
  static const double Height = 120;
  @override
  Widget build(BuildContext context) {
    return DragTarget<Sight>(
      builder: (
        BuildContext context,
        List<Sight> candidateData,
        List<dynamic> rejectedData,
      ) {
        return LongPressDraggable(
          data: sight,
          axis: Axis.vertical,
          feedback: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: sightCardVisited(context)),
          child: sightCardVisited(context),
          childWhenDragging: const SizedBox.shrink(),
        );
      },
    );
  }

  Widget sightCardVisited(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SightDetail(sight: sight)));
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
          child: Dismissible(
            background: const SizedBox.shrink(),
            secondaryBackground: deleteBackground(context),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              sight.wantToVisit = !sight.wantToVisit;
              sight.visited = !sight.visited;
              onDelete();
            },
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
                      height: Height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
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
                          '${sight.titleType}',
                          style: Theme.of(context).textTheme.bodyText2,
                        )),
                    Positioned(
                      //!button share
                      top: 1,
                      right: 40,
                      child: IconButton(
                        icon: Icon(Icons.share, size: 28, color: iconColor),
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
                        icon: Icon(Icons.close, size: 30, color: iconColor),
                        onPressed: () {
                          onDelete();
                          print('fyui');
                          sight.visited = !sight.visited;
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
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
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Цель достигнута 12 окт. 2020',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${sight.workHours}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
