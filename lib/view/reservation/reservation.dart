import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reservingDateTimeController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _selectedItem;
  final List<String> _dropdownItems = [
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  String? _validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select an option';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Reserve a table',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // customer name section
                  // heading
                  heading('Please tell us your name *'),
                  // textfield
                  TextFormField(
                    controller: _nameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 185, 185),
                                width: 0.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 122, 122, 122),
                                width: 1.5))),
                    validator: (value) {
                      if (value!.isEmpty || value == ' ') {
                        return 'Please enter your name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  // phone section
                  // heading
                  heading('Phone number *'),
                  // textfield
                  TextFormField(
                    controller: _phoneController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 185, 185),
                                width: 0.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 122, 122, 122),
                                width: 1.5))),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value!.isEmpty || value == ' ') {
                        return 'Please enter your phone number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  // number of seats section
                  // heading
                  heading('Number of guests *'),
                  // textfield
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 185, 185, 185),
                              width: 0.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 122, 122, 122),
                              width: 1.5)),
                    ),
                    icon: Icon(Icons.keyboard_arrow_down),
                    dropdownColor: Colors.white,
                    value: _selectedItem,
                    items: _dropdownItems.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                    },
                    validator: _validateDropdown,
                  ),

                  // reservation date and time
                  // heading
                  heading('When are you planning to visit *'),
                  // textfield
                  TextFormField(
                    controller: _reservingDateTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 185, 185),
                                width: 0.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 122, 122, 122),
                                width: 1.5)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              showDateTimePicker();
                            },
                            icon: Icon(Icons.calendar_month_outlined))),
                    // validator
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select date and time';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  // submit
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        print('validate');
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 30, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 1),
                              color: Color.fromARGB(139, 84, 117, 240),
                            )
                          ]),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // cancel
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 0, 30, 255), width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                            color: Color.fromARGB(139, 84, 117, 240),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 30, 255),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // pick date and time for reserving
  showDateTimePicker() {
    DateTime selectedDateTime = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    ).then((selectedDate) {
      // After selecting the date, display the time picker.
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          // Handle the selected date and time here.
          if (selectedTime != null) {
            selectedDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            _reservingDateTimeController.text = DateFormat('dd-MM-yyyy kk:mm a')
                .format(selectedDateTime)
                .toString();
          }
        });
      }
    });
  }

  // heading
  Padding heading(String heading) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '$heading',
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 185, 185, 185)),
      ),
    );
  }
}
