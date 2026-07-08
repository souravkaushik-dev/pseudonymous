import 'package:flutter/widgets.dart';

class OnboardingModel {
  final Widget topWidget;
  final String title;
  final String description;

  const OnboardingModel({
    required this.topWidget,
    required this.title,
    required this.description,
  });
}