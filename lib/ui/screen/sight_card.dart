import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Strings.dart';
import 'package:places/res/colors.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({this.sight});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageBox(sight: sight),
        DescriptionBox(sight: sight),
      ],
    );
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
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${sight.details}',
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
              style: Theme.of(context).textTheme.bodyText2,
            )),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              print('button "add to fav" pressed');
            },
            icon: SvgPicture.asset(
              favorite,
              width: 25,
              color: iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
