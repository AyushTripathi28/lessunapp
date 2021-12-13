// // import 'package:coach/widget/butt_challenge_tile.dart';
// // import 'package:coach/widget/video_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:lessunapp/progressar.dart';

// // import '../../../custom_icons_icons.dart';
// // import '../bottom_bar.dart';

// class Exercise extends StatefulWidget {
//   final data;
//   final value;
//   const Exercise({Key? key, this.data, this.value = 0}) : super(key: key);

//   @override
//   State<Exercise> createState() => _ExerciseState();
// }

// class _ExerciseState extends State<Exercise> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           automaticallyImplyLeading: false,
//           title: Image.asset(
//             "assets/appbar.png",
//             height: 25,
//             fit: BoxFit.cover,
//           ),
//           centerTitle: true,
//         ),
//         body: Container(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Padding(
//                     padding: const EdgeInsets.all(13.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.arrow_back_ios),
//                             onPressed: () {
//                               // Navigator.of(context).push(MaterialPageRoute(
//                               //     builder: (context) => const BottomBar()));
//                             },
//                             color: Colors.black,
//                           ),
//                           Theme(
//                             data: Theme.of(context).copyWith(
//                               cardColor: Colors.white,
//                             ),
//                             child: PopupMenuButton(
//                               itemBuilder: (context) {
//                                 return List.generate(2, (index) {
//                                   return PopupMenuItem(
//                                     child: Text(
//                                       'button no $index',
//                                       style:
//                                           const TextStyle(color: Colors.black),
//                                     ),
//                                   );
//                                 });
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   child: Padding(
//                     padding: const EdgeInsets.all(50.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) =>
//                                     ExerciseDate(value: widget.value + 3.3)));
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: const Color(0xff79dd72),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                             // side: BorderSide(
//                             //   color: Colors.green.shade500,
//                             //   width: 2.5,
//                             // )
//                           ),
//                           child: const Text(
//                             "Complete",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 18,
//                               //fontWeight: FontWeight.w800
//                             ),
//                           )),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
