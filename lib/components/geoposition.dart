import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

List<Sight> listAreaByRadius(
    List<Sight> inputList, userGeoPoint, RangeValues rangeValues) {
  List<Sight> listAreaByRadius = [];
  inputList.forEach((element) {
    if (arePointsNear(
        element.coordinatePoint,
        CoordinatePoint(52.512044, 107.037643),
        rangeValues)) listAreaByRadius.add(element);
  });
  return listAreaByRadius;
}

List<Sight> sortedByRadius = [];

bool arePointsNear(
    CoordinatePoint checkPoint, CoordinatePoint centerPoint, RangeValues km) {
  var kmEnd = km.end / 1000;
  var kmStart = km.start / 1000;
  var ky = 40000 / 360;
  var kx = Math.cos(Math.pi * centerPoint.lat / 180.0) * ky;
  var dx = (centerPoint.lng - checkPoint.lng).abs() * kx;
  var dy = (centerPoint.lat - checkPoint.lat).abs() * ky;
  return Math.sqrt(dx * dx + dy * dy) <= kmEnd &&
      Math.sqrt(dx * dx + dy * dy) >= kmStart;
}
