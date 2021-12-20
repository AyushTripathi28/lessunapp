// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomeFeedPost extends StatefulWidget {
  HomeFeedPost({
    Key? key,
    required this.title,
    required this.type,
    required this.userImg,
    this.replyCount = 0,
    this.likeCount = 0,
    this.ifPined = false,
    this.ifLiked = false,
  }) : super(key: key);
  final String? title;
  final String? type;
  final String userImg;
  final int replyCount;
  int likeCount;
  bool ifPined;
  bool ifLiked;

  @override
  State<HomeFeedPost> createState() => _HomeFeedPostState();
}

class _HomeFeedPostState extends State<HomeFeedPost> {
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
                        backgroundImage:
                            AssetImage('assets/images/profilepic.png'),
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
                            widget.title!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Chip(
                            label: Text(
                              widget.type!,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.ifPined = !widget.ifPined;
                        });
                      },
                      child: Icon(
                        widget.ifPined ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.indigo[900],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.ifLiked = !widget.ifLiked;
                          widget.likeCount = widget.ifLiked
                              ? widget.likeCount + 1
                              : widget.likeCount - 1;
                        });
                      },
                      child: Icon(
                        widget.ifLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        // size: 8,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(widget.likeCount.toString()),
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
