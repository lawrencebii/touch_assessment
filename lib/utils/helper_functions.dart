// safely get a string from map(to avoid null values)

import 'dart:developer';

String getStringFromMap(map, key) {
  String res = '';
  try {
    res = map[key];
    return res;
  } catch (e) {
    log("$map-$key  $e");
    return '';
  }
}

// safely get a dynamic val from map(to avoid null values)
dynamic getDyFromMap(map, key) {
  dynamic res;
  try {
    res = map[key];
    return res;
  } catch (e) {
    log("$map-$key  $e");
    return res;
  }
}
