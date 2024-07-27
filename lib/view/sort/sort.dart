import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_table_reservation/viewModel/table_provider.dart';

class Sort extends StatelessWidget {
  const Sort({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select the number of seats',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              // all
              numberOfSeats(context: context),
              // 4 seats
              numberOfSeats(number: 4, context: context),
              Divider(),
              // 6 seats
              numberOfSeats(number: 6, context: context),
              Divider(),
              // 8 seats
              numberOfSeats(number: 8, context: context),
              Divider(),
              // 10 seats
              numberOfSeats(number: 10, context: context),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  ListTile numberOfSeats({int? number, required BuildContext context}) {
    return ListTile(
      onTap: () async {
        await Provider.of<TableProvider>(context, listen: false)
            .sortBySeatNumber(number);
        Navigator.pop(context);
      },
      contentPadding: EdgeInsets.zero,
      title: Text(
        number != null ? '$number seats' : "all seats",
        style: TextStyle(
            fontSize: 14, color: const Color.fromARGB(255, 144, 144, 144)),
      ),
    );
  }
}
