import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

List<Sight> listAreaByRadius(
  List<Sight> inputList,
  CoordinatePoint userGeoPoint,
  RangeValues rangeValues,
) {
  final List<Sight> listAreaByRadius = [];
  inputList.forEach((element) {
    if (arePointsNear(
      element.coordinatePoint,
      CoordinatePoint(52.512044, 107.037643),
      rangeValues,
    )) listAreaByRadius.add(element);
  });
  return listAreaByRadius;
}

List<Sight> sortedByRadius = [];

bool arePointsNear(
  CoordinatePoint checkPoint,
  CoordinatePoint centerPoint,
  RangeValues km,
) {
  final kmEnd = km.end / 1000;
  final kmStart = km.start / 1000;
  const ky = 40000 / 360;
  final kx = Math.cos(Math.pi * centerPoint.lat / 180.0) * ky;
  final dx = (centerPoint.lng - checkPoint.lng).abs() * kx;
  final dy = (centerPoint.lat - checkPoint.lat).abs() * ky;
  return Math.sqrt(dx * dx + dy * dy) <= kmEnd &&
      Math.sqrt(dx * dx + dy * dy) >= kmStart;
}
