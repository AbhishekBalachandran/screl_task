import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_table_reservation/model/table_model.dart';
import 'package:restaurant_table_reservation/view/home/home.dart';
import 'package:restaurant_table_reservation/viewModel/table_provider.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(TableModalAdapter());
  await Hive.openBox<List<TableModal>>('tableBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TableProvider>(
          create: (context) => TableProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
