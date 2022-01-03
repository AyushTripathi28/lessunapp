// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lessunapp/widgets/homefeed_container.dart';
import 'package:zefyrka/zefyrka.dart';

class FeedPostDetailPage extends StatefulWidget {
  FeedPostDetailPage({
    Key? key,
    required this.body,
    required this.category,
    required this.likes,
    required this.owner,
    required this.owneravatar,
    required this.title,
    required this.madeat,
    required this.id,
    this.replyCount = 0,
    // this.likeCount = 0,

    this.ifPined = false,
    // this.ifLiked = false,
  }) : super(key: key);
  final String id;
  final String body;
  final String category;
  final List likes;
  final String owner;
  final String owneravatar;
  final String title;
  final String madeat;
  int replyCount;
  // int likeCount;
  bool ifPined;
  // bool ifLiked;

  @override
  State<FeedPostDetailPage> createState() => _FeedPostDetailPageState();
}

class _FeedPostDetailPageState extends State<FeedPostDetailPage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('',
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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                widget.ifPined = !widget.ifPined;
                FirebaseFirestore.instance
                    .collection("forum")
                    .doc(widget.id)
                    .update({
                  "pinned": widget.ifPined,
                });
              });
            },
            icon: Icon(
              widget.ifPined ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.indigo[900],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "by:  ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      TextSpan(
                                        text: widget.owner,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.madeat,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      ZefyrEditor(
                          padding: EdgeInsets.all(16),
                          controller: ZefyrController(
                              NotusDocument.fromJson(jsonDecode(widget.body)))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(() {
                                widget.likes.contains(user!.uid)
                                    ? widget.likes.remove(user!.uid)
                                    : widget.likes.add(user!.uid);
                              });
                              print(widget.likes);
                              print("working on adding");
                              await FirebaseFirestore.instance
                                  .collection("forum")
                                  .doc(widget.id)
                                  .update({
                                "likes": widget.likes,
                              });
                              print("added successfull");
                            },
                            child: Icon(
                              widget.likes.contains(user!.uid)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              // size: 8,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          widget.likes.isEmpty
                              ? Text("0")
                              : Text(widget.likes.length.toString()),
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
                          Text(widget.replyCount.toString()),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      // Expanded(
                      //   child: SizedBox(
                      //     width: 0,
                      //   ),
                      // ),
                      Expanded(
                        child: StreamBuilder(
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
                                  height: 50,

                                  child: ListView(
                                      dragStartBehavior: DragStartBehavior.down,
                                      physics: NeverScrollableScrollPhysics(),
                                      // scrollDirection: Axis.horizontal,
                                      children:
                                          snapshot.data!.docs.map((color) {
                                        if (color.id ==
                                            widget.category.toLowerCase()) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Chip(
                                                label: Text(
                                                  widget.category,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    HexColor(color["color"]),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ],
                                          );

                                          // Container(
                                          //   //
                                          //   width: 15,
                                          //   height: 15,
                                          //   decoration: BoxDecoration(
                                          //     color: HexColor(color["color"]),
                                          //   ),
                                          // );
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // SizedBox(height: 10),
          Expanded(
            child: Container(
              width: size.width,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                    offset: Offset(
                      0.0, // horizontal, move right 10
                      10.0, // vertical, move down 10
                    ),
                  )
                ],
              ),
              child: Center(
                child: Text("Reply shown here"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/* 



*/
