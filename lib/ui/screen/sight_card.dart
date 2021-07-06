import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';
import 'sight_details.dart';

class SightCard extends StatefulWidget {
  final Sight sight;

  const SightCard({Key key, this.sight}) : super(key: key);

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageBox(sight: widget.sight),
          DescriptionBox(sight: widget.sight),
        ],
      ),
      Positioned.fill(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                SightDetail.routeName,
                arguments: widget.sight.id,
              );
            },
          ),
        ),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: InkWell(
          onTap: () {
            setState(() {
              widget.sight.wantToVisit = !widget.sight.wantToVisit;
              print(widget.sight.wantToVisit);
            });
          },
          child: widget.sight.wantToVisit
              ? SvgPicture.asset(favorite2, width: 25, color: iconColor)
              : SvgPicture.asset(
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
  final Sight sight;

  const DescriptionBox({
    Key key,
    @required this.sight,
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
            '${sight.name}',
            maxLines: 1,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${sight.details}',
            maxLines: 2,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final Sight sight;

  const ImageBox({
    Key key,
    @required this.sight,
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
              '${sight.titleType}',
              style: Theme.of(context).textTheme.bodyText2,
            )),
      ],
    );
  }
}
