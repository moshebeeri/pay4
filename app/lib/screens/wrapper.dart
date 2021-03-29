import 'package:flutter/material.dart';
import 'package:pay4/models/pay4user.dart';
import 'package:pay4/screens/authenticate/authenticate.dart';
import 'package:pay4/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Pay4User>(context);
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
