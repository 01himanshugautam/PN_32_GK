import 'package:flutter/material.dart';
import 'package:gk/data/repository/auth.repository.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider();
  var authRepository = AuthRepository();

  List _items = [];

  List get items {
    return [..._items];
  }

  login(String username, String password) async {
    var response = await authRepository.login(username, password);
    notifyListeners();
    return response;
  }
}
