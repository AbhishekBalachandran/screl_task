import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_table_reservation/utils/toast.dart';
import 'package:restaurant_table_reservation/view/reservation/reservation.dart';
import 'package:restaurant_table_reservation/view/sort/sort.dart';
import 'package:restaurant_table_reservation/viewModel/table_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then(
      (value) {
        Provider.of<TableProvider>(context, listen: false).getTablesList();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TableProvider>(context);
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(66, 153, 153, 153)),
              child: const Center(
                child: Icon(Icons.person),
              ),
            ),
          )
        ],
        centerTitle: true,
        title: const Text(
          'Table Reservation',
          style: TextStyle(),
        ),
      ),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 4, 46, 80),
              ),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // heading //table
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      '${provider.seats}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Sort(),
                            ));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromARGB(255, 204, 204, 204),
                                width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 0,
                                  offset: Offset(0, 1),
                                  color: Color.fromARGB(255, 228, 228, 228))
                            ]),
                        child: const Center(
                          child: Icon(Icons.sort),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // list of table
                  Expanded(
                    child: (provider.tables == null)
                        ? Center(
                            child: Text('Empty list'),
                          )
                        : ListView.separated(
                            itemCount: provider.sortedTables!.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                provider.sortedTables![index].status.first
                                            .status ==
                                        'available'
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Reservation(),
                                        ))
                                    : Toast.show(
                                        'Table is not available for reservation',
                                        context);
                              },
                              child: Container(
                                height: height * 0.34,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 242, 242, 242),
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 3,
                                          spreadRadius: 0,
                                          offset: Offset(0, 1),
                                          color: Color.fromARGB(
                                              255, 228, 228, 228))
                                    ]),
                                child: Column(
                                  children: [
                                    // image
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                      child: Container(
                                        child: Image.asset(
                                          'assets/images/dining_table.jpg',
                                          fit: BoxFit.cover,
                                          height: height * 0.15,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    // table name
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // title
                                              Text(
                                                'Table Name',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 201, 201, 201),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              // table name
                                              Text(
                                                '${provider.sortedTables![index].table}',
                                                style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 21, 21, 21),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          ),
                                          // capacity
                                          Text(
                                            '${provider.sortedTables![index].capacity} seats',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 150, 150, 150),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // status
                                          Row(
                                            children: [
                                              Text(
                                                provider
                                                            .sortedTables![
                                                                index]
                                                            .status
                                                            .first
                                                            .status ==
                                                        'available'
                                                    ? 'Available'
                                                    : '${provider.sortedTables![index].status.first.status}',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 67, 67, 67),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: provider
                                                            .sortedTables![
                                                                index]
                                                            .status
                                                            .first
                                                            .status ==
                                                        'available'
                                                    ? Colors.green
                                                    : Colors.red,
                                                radius: 6,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Will be available on - ',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 67, 67, 67),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w200),
                                              ),
                                              Text(convertToDate(provider
                                                  .sortedTables![index]
                                                  .status
                                                  .first
                                                  .timestamp))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }

  // convert to date time
  String convertToDate(int timestamp) {
    DateTime formattedDateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String dateTime =
        DateFormat('EEEE, MMM d, hh:mm a').format(formattedDateTime);
    print(dateTime);
    return dateTime;
  }
}
