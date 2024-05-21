import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    _maxedId = userId;
    notifyListeners();
    try {
      var res = await _service.getRequestApi(
          endpoint: "${baseUrl}user/$userId", context: context);
      _currentUser = UserModel.fromMap(res['data']);
      prefillDetails();
      _loadingUsers = false;
      notifyListeners();
    } catch (e) {
      _currentUser =
          _users.where((UserModel user) => user.id == userId).toList().first;
      prefillDetails();
      _loadingUsers = false;
      notifyListeners();
      log("getUsers Error $e");
    }
  }

  String _maxedId = "";
  get maxedID => _maxedId;
  void setMaxedId(id) {
    log("Max Id set");
    if (_maxedId != id) {
      _maxedId = id;
    } else {
      _maxedId = '';
    }
    notifyListeners();
  }

  void patchUser(BuildContext context, UserModel userModel) async {
    var userId = userModel.id;
    _loadingUsers = true;
    notifyListeners();
    var body = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "occupation": occupationController.text.trim(),
      "bio": bioController.text.trim(),
    };
    try {
      var res = await _service.patchRequestApi(
        endpoint: "${baseUrl}user/$userId",
        context: context,
        body: body,
      );
      // _currentUser = UserModel.fromMap(res['data']);
      log(res.toString());
      if (res['status'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Updated Successfully')),
        );
        _currentUser = UserModel.fromMap(res['data']);
        getUsers(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not update user!!')),
        );
      }
      _loadingUsers = false;
      notifyListeners();
    } catch (e) {
      _currentUser =
          _users.where((UserModel user) => user.id == userId).toList().first;
      _loadingUsers = false;

      notifyListeners();
      log("getUsers Error $e");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  void prefillDetails() {
    UserModel user = _currentUser!;
    nameController.text = user.name;
    emailController.text = user.email;
    occupationController.text = user.occupation;
    bioController.text = user.bio;
    notifyListeners();
  }

  void clearDetails() {
    nameController.text = '';
    emailController.text = '';
    occupationController.text = '';
    bioController.text = '';
    notifyListeners();
  }

  TextEditingController searchController = TextEditingController();
  bool _isSearching = false;
  get isSearching => _isSearching;
  List<UserModel> _searchUsers = [];
  List<UserModel> get searchUsers => _searchUsers;
  void setIsSearching() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void searchUsersFunction(String val) {
    if (val.isNotEmpty) {
      log(val.toString());
      _searchUsers = _users
          .where((UserModel user) =>
              user.email.toLowerCase().contains(val.toLowerCase()) ||
              user.occupation.toLowerCase().contains(val.toLowerCase()) ||
              user.name.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      _searchUsers = _users;
    }
    // Debugging: Print out the search results
    print("Search results for '$val': ${_searchUsers.length} users found");

    notifyListeners();
  }
}
