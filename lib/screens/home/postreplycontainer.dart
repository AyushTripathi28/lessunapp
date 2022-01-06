// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostReplyContainer extends StatefulWidget {
  const PostReplyContainer(
      {Key? key, this.replyContent, this.replyById, this.replyDate})
      : super(key: key);

  final String? replyContent;
  final String? replyById;
  final Timestamp? replyDate;

  @override
  State<PostReplyContainer> createState() => _PostReplyContainerState();
}

class _PostReplyContainerState extends State<PostReplyContainer> {
  String? img;
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    getReplyData();
    super.initState();
  }

  void getReplyData() async {
    print("----------------Accesing DATA-----------------------------------");
    // User? user = FirebaseAuth.instance.currentUser;
    // print(user!.uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.replyById)
        .get()
        .then((value) => {
              setState(() {
                img = value["profilepic"];
                name = value["name"];
              })
            });

    // print({_userName});
    print("---------------- DATA Access-----------------------------------");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: 50,
        ),
        margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
        // width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(
                0.4, // horizontal, move right 10
                0.4, // vertical, move down 10
              ),
            )
          ],
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profilepic.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            name != null ? name! : '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy')
                                .format(widget.replyDate!.toDate()),
                            // replyDate?.toDate().toString() ?? "",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        // color: Colors.black,
                      ),
                      Text(
                        widget.replyContent ?? "",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        // textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
