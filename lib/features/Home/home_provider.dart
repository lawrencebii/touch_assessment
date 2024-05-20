import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:touch_assessment/utils/api_service_helper.dart';
import 'package:touch_assessment/utils/constants.dart';

import 'Models/user_model.dart';

class HomeProvider extends ChangeNotifier {
  GenericService _service = GenericService();
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  bool _loadingUsers = false;
  get loadingUsers => _loadingUsers;
  void getUsers(context) async {
    _loadingUsers = true;
    notifyListeners();
    try {
      var res = await _service.getRequestApi(
          endpoint: "${baseUrl}users", context: context);
      _users = (res['data'] as List).map((e) => UserModel.fromMap(e)).toList();
      _loadingUsers = false;
      notifyListeners();
    } catch (e) {
      _loadingUsers = false;
      notifyListeners();
      log("getUsers Error $e");
    }
  }

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  void getOneUser(BuildContext context, String userId) async {
    _loadingUsers = true;
    notifyListeners();
    try {
      var res = await _service.getRequestApi(
          endpoint: "${baseUrl}users", context: context);
      _currentUser = UserModel.fromMap(res['data']);
      _loadingUsers = false;
      notifyListeners();
    } catch (e) {
      _loadingUsers = false;
      notifyListeners();
      log("getUsers Error $e");
    }
  }

  void patchUser(UserModel userModel) async {}

  String _maxedId = "";
  get maxedID => _maxedId;
  void setMaxedId(id) {
    _maxedId = id;
    notifyListeners();
  }
}
