// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int? groupValue = 0;
  static const List<String> selections = <String>[
    'All',
    'AP',
    'IB',
    'Announcements',
    'ComSci',
    'Suggestions',
    'Econ/Business',
    'Chemistry',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xffEDF1F5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Color(0xffEDF1FE),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile<int>(
                  value: index,
                  groupValue: groupValue,
                  toggleable: true,
                  title: Text(selections[index]),
                  onChanged: (int? value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                  dense: true,
                  visualDensity: VisualDensity.compact,
                );
              },
              itemCount: selections.length,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selections[groupValue!]);
              },
              child: Text("DONE"))
        ],
      ),
    );
  }
}
