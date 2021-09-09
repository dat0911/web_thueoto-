import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thueoto/data.dart';
import 'package:thueoto/connect/url.dart';
List ifocar = [];
Future<List> fetchPosts() async {

  final response =
  await http.get(Uri.parse(url_cars));
  ifocar = jsonDecode(response.body);
  return ifocar;
}
fetchWpPostImageUrl(href) async {
  final response =
  await http.get(href);
  var convertDatatoJson = jsonDecode(response.body);
  return convertDatatoJson;
}

