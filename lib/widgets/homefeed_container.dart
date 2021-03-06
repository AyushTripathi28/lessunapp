// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeFeedPost extends StatefulWidget {
  const HomeFeedPost({
    Key? key,
    required this.title,
    required this.category,
    required this.userId,
    this.replyCount = 0,
    this.ifPined = false,
    // this.ifLiked = false,
    required this.id,
    required this.likes,
  }) : super(key: key);
  final String id;
  final String? title;
  final String? category;
  final String? userId;
  final int replyCount;
  final List likes;
  final bool ifPined;

  @override
  State<HomeFeedPost> createState() => _HomeFeedPostState();
}

class _HomeFeedPostState extends State<HomeFeedPost> {
  User? user = FirebaseAuth.instance.currentUser;
  String userImg = "";
  int replyCount = 0;
  bool ifPined = false;
  List likes = [];

  // List likes;

  // bool ifPined;

  @override
  void initState() {
    getUserPhotoData();
    replyCount = widget.replyCount;
    ifPined = widget.ifPined;
    super.initState();
  }

  void getUserPhotoData() async {
    print("----------------Accesing DATA-----------------------------------");
    // User? user = FirebaseAuth.instance.currentUser;
    // print(user!.uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get()
        .then((value) => {
              setState(() {
                userImg = value["profilepic"];
              })
            });

    // print({_userName});
    print("---------------- DATA Access-----------------------------------");
  }

  // void getUserData() async {
  //   print("----------------Accesing DATA-----------------------------------");
  //   User? user = FirebaseAuth.instance.currentUser;
  //   print(user!.uid);
  //   var result = await FirebaseFirestore.instance
  //       .collection('postReply')
  //       .doc(widget.id)
  //       .collection("reply")
  //       .get();
  //   // .get();
  //   print(result.docs.length);

  //   setState(() {
  //     widget.replyCount = result.docs.length;
  //   });
  //   // print();
  //   print("---------------- DATA Access-----------------------------------");
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: SizedBox(
          width: size.width * 0.9,
          // height: size.height * 0.15,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: userImg.isNotEmpty
                            ? NetworkImage(
                                userImg,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            widget.title!.length < 50
                                ? widget.title!
                                : widget.title!.substring(0, 50) + '...',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("category")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      //   child: Text(
                                      // "Loading",
                                      // style: TextStyle(
                                      //     color: Colors.black, fontSize: 16),
                                      // maxLines: 1,
                                      // )
                                      );
                                } else {
                                  return SizedBox(
                                    // width: size.width * 0.3,
                                    height: size.height * 0.06,
                                    child: ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        // scrollDirection: Axis.horizontal,
                                        children:
                                            snapshot.data!.docs.map((color) {
                                          if (color.id ==
                                              widget.category!.toLowerCase()) {
                                            return Row(
                                              children: [
                                                Chip(
                                                  label: Text(
                                                    widget.category!,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor:
                                                      HexColor(color["color"]),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return SizedBox(
                                                //
                                                width: 0,
                                                height: 0);
                                          }
                                        }).toList()),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          ifPined = !ifPined;
                          FirebaseFirestore.instance
                              .collection("forum")
                              .doc(widget.id)
                              .update({
                            "pinned": ifPined,
                          });
                        });
                      },
                      child: Icon(
                        ifPined ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.indigo[900],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        setState(() {
                          likes.contains(user!.uid)
                              ? likes.remove(user!.uid)
                              : likes.add(user!.uid);
                        });
                        print(likes);
                        print("working on adding");
                        await FirebaseFirestore.instance
                            .collection("forum")
                            .doc(widget.id)
                            .update({
                          "likes": likes,
                        });
                        print("added successfull");
                      },
                      child: Icon(
                        likes.contains(user!.uid)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        // size: 8,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    likes.isEmpty ? Text("0") : Text(likes.length.toString()),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.comment,
                      // size: 8,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(replyCount.toString()),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ListTile(
//         leading: CircleAvatar(
//           radius: 30,
//           backgroundImage: AssetImage('assets/images/profilepic.png'),
//         ),
//         title: Text(
//           title!,
//           style: TextStyle(fontSize: 25),
//         ),
//         subtitle: Row(
//           children: [
//             Chip(label: Text(type!)),
//           ],
//         ),
//         // dense: true,
//         minVerticalPadding: 0,
//         minLeadingWidth: 0,
//         contentPadding: EdgeInsets.all(0),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.bookmark,
//                 size: 8,
//               ),
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.favorite_border,
//                     size: 8,
//                   ),
//                 ),
//                 Text(likeCount.toString()),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.comment,
//                     size: 8,
//                   ),
//                 ),
//                 Text(replyCount.toString()),
//               ],
//             ),
//           ],
//         ),
//         horizontalTitleGap: 0,
//       ),

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}



 // widget.ifPined = !widget.ifPined;
                          // FirebaseFirestore.instance
                          //     .collection("forum")
                          //     .where("id", isEqualTo: widget.id)
                          //     .where("likes",
                          //         arrayContains: widget.id.toString())
                          //     .get()
                          //     .then((value) => {
                          //           value.docs.forEach((doc) {
                          //             if (doc.id == widget.id) {
                          //               FirebaseFirestore.instance
                          //                   .collection("forum")
                          //                   .doc(doc.id)
                          //                   .update({
                          //                 "likes": widget.likes,
                          //               });
                          //             }
                          //           })
                          //         });