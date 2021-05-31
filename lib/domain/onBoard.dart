import 'package:flutter/material.dart';
import 'package:places/res/Strings.dart';

class OnBoardingItem {
  final String assetName;
  final String title;
  final String description;

  OnBoardingItem({
    @required this.assetName,
    @required this.title,
    @required this.description,
  });
}

List<OnBoardingItem> itemOnBoardList = [
  OnBoardingItem(
    assetName: signpost,
    description: onBoardingDescription,
    title: onBoardingTitle,
  ),
  OnBoardingItem(
    assetName: bag,
    description: onBoardingDescription2,
    title: onBoardingTitle2,
  ),
  OnBoardingItem(
    assetName: tapHand,
    description: onBoardingDescription3,
    title: onBoardingTitle3,
  ),
];
