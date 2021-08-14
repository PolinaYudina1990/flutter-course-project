import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'package:provider/provider.dart';
import 'sight_details.dart';

class SightCard extends StatelessWidget {
  final Place place;

  const SightCard({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageBox(place: place),
          DescriptionBox(place: place),
        ],
      ),
      Positioned.fill(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SafeArea(
                    minimum: const EdgeInsets.only(top: 50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          SightDetail(sightId: place.id),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    closeIcon,
                                    color: primaryColor,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
              // Navigator.pushNamed(
              //   context,
              //   '/sightDetails',
              //   arguments: widget.sight.id,
              // );
            },
          ),
        ),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: InkWell(
          onTap: () {
            Provider.of<PlaceInteractor>(context).addToFavorites(place);
          },
          child:
              // place.wantToVisit
              //     ? SvgPicture.asset(favorite2, width: 25, color: iconColor)
              // :
              SvgPicture.asset(
            favorite,
            width: 25,
            color: iconColor,
          ),
        ),
      ),
    ]);
  }
}

class DescriptionBox extends StatelessWidget {
  final Place place;

  const DescriptionBox({
    Key key,
    @required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: const Radius.circular(15),
          bottomRight: const Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${place.name}',
            maxLines: 1,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${place.description}',
            maxLines: 2,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final Place place;

  const ImageBox({
    Key key,
    @required this.place,
  }) : super(key: key);

  static const double Height = 100;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
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
              '${place.placeType}',
              style: Theme.of(context).textTheme.bodyText2,
            )),
      ],
    );
  }
}
