import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_table_reservation/model/table_model.dart';

class TableProvider extends ChangeNotifier {
  final Box<List<TableModal>> tableBox = Hive.box<List<TableModal>>('tableBox');

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<TableModal>? _tables;
  List<TableModal>? get tables => _tables;

  List<TableModal>? _sortedTables;
  List<TableModal>? get sortedTables => _sortedTables;

  String seats = 'All tables';

  // get table list
  getTablesList() async {
    final url = Uri.parse('http://192.168.0.68:5220/interview/table/get');
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        _tables = responseBody
            .map<TableModal>((table) => TableModal.fromJson(table))
            .toList();
        saveLocally();
        _sortedTables = _tables;
        _isLoading = false;
        notifyListeners();
      } else {
        print("Table response failed");
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("Something went wrong  $e");
      _isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  // sort
  sortBySeatNumber(int? number) {
    _isLoading = true;
    notifyListeners();
    if (number != null) {
      _sortedTables =
          _tables?.where((table) => table.capacity == number).toList();
      seats = '$number seat tables';
    } else {
      _sortedTables = _tables;
      seats = 'All tables';
    }
    _isLoading = false;
    notifyListeners();
  }

  void saveLocally() {
    tableBox.put('tables', _tables!);
  }
}
