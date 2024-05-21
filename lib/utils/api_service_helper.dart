import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GenericService {
  Future<dynamic> getRequestApi({
    required String endpoint,
    required BuildContext context,
  }) async {
    try {
      Response response = await get(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      if (response.statusCode == 401) {
        // endoint is unauthorized so I can tap the user journey here and
        // redirect to login or refresh access and call the same function
        log("Unauthorized");
      } else {
        final responseData = json.decode(response.body);
        return {
          'data': responseData,
          "status": response.statusCode,
        };
      }
    } catch (e) {
      return {"reason": "Error $e"};
    }
  }

  Future<dynamic> patchRequestApi({
    required String endpoint,
    required BuildContext context,
    required body,
  }) async {
    try {
      Response response = await patch(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encoder.convert(body),
      );
      print(endpoint);
      print(response.headers.toString());
      if (response.statusCode == 401) {
        // endoint is unauthorized so I can tap the user journey here and
        // redirect to login or refresh access and call the same function
        log("Unauthorized");
      } else {
        final responseData = json.decode(response.body);
        return {
          'data': responseData,
          "status": response.statusCode,
        };
      }
    } catch (e) {
      return {"reason": "Error $e"};
    }
  }
}
