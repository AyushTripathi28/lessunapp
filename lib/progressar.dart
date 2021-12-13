// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lessunapp/complete.dart';
// import 'package:lessunapp/progressbarcustom.dart';
// // import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// // import 'exercise.dart';

// class ExerciseDate extends StatefulWidget {
//   final data;
//   double value;

//   ExerciseDate({Key? key, this.data, this.value = 0}) : super(key: key);
//   @override
//   State<ExerciseDate> createState() => _ExerciseDateState();
// }

// class _ExerciseDateState extends State<ExerciseDate> {
//   late String _dateCount;
//   late String _range;

//   @override
//   void initState() {
//     _dateCount = '';
//     _range = '';
//     print(widget.data);
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         title: Image.asset(
//           "assets/appbar.png",
//           height: 25,
//           fit: BoxFit.cover,
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(13.0),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.black,
//                         ),
//                         RichText(
//                             text: const TextSpan(
//                                 text: 'RETO',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w800),
//                                 children: [
//                               TextSpan(
//                                 text: 'GLÚTEO',
//                                 style: TextStyle(
//                                     color: Color(0xff79dd72),
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w800),
//                               )
//                             ])),
//                         Theme(
//                           data: Theme.of(context).copyWith(
//                             cardColor: Colors.white,
//                           ),
//                           child: PopupMenuButton(
//                             itemBuilder: (context) {
//                               return List.generate(2, (index) {
//                                 return PopupMenuItem(
//                                   child: Text(
//                                     'button no $index',
//                                     style: const TextStyle(color: Colors.black),
//                                   ),
//                                 );
//                               });
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 // SfDateRangePicker(
//                 //   //onSelectionChanged: _onSelectionChanged,
//                 //   selectionMode: DateRangePickerSelectionMode.range,
//                 //   initialSelectedRange: PickerDateRange(
//                 //       DateTime.now().subtract(const Duration(days: 4)),
//                 //       DateTime.now().add(const Duration(days: 3))),
//                 // ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Avance',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                     ),
//                     Text(
//                       widget.value.toStringAsFixed(1) + "%",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ProgressBar(
//                   max: 100,
//                   current: widget.value,
//                   color: Color(0xff79dd72),
//                 ),
//                 const SizedBox(
//                   height: 100,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => Exercise(
//                                 data: widget.data,
//                                 value: widget.value,
//                               )));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       fixedSize: const Size(240, 40),
//                       primary: const Color(0xff79dd72),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                     ),
//                     child: const Text(
//                       "INICO",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         //fontWeight: FontWeight.w800
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
