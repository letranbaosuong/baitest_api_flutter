import 'package:baitestapi/src/app.dart';
import 'package:baitestapi/src/blocs/blocs.dart';
import 'package:flutter/material.dart';

void main() {
  final _staffBloc = StaffBloc.getInstance();
  final _departmentBloc = DepartmentBloc.getInstance();
  _staffBloc.initialize();
  _departmentBloc.initialize();
  runApp(App());
}
