import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/Text_styles.dart';
import 'package:places/res/colors.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({this.sight});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageBox(sight: sight),
          SizedBox(
            height: 10,
          ),
          DescriptionBox(sight: sight),
        ],
      ),
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
    final size = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: boxDescription,
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
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: size * 0.5),
            child: Text(
              '${sight.name}',
              style: textReg16bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${sight.details}',
            style: textReg15desc,
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
          //!button to visit
          top: 16,
          right: 16,
          child: Icon(Icons.favorite_outline, size: 30, color: backgroundColor),
        ),
      ],
    );
  }
}
