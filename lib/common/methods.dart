import 'package:flutter/material.dart';

double widthLayout(BuildContext context){
  return MediaQuery.of(context).size.width;
}
double heightLayout(BuildContext context){
  return MediaQuery.of(context).size.height;
}

TextTheme textTheme(BuildContext context){
  return Theme.of(context).textTheme;
}