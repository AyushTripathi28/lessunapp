// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:zefyrka/zefyrka.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({Key? key}) : super(key: key);

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  String category = "IB";
  String title = "";
  String body = "";
  String filter = "";
  List<String> hashtags = [];
  final formkey = GlobalKey<FormState>();
  final ZefyrController _controller = ZefyrController();
  TextEditingController controller = TextEditingController();

  String save() {
    final content = jsonEncode(_controller.document);
    return content.toString();
  }

  @override
  void initState() {
    super.initState();
    //fill countries with objects
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Post',
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
            icon: Icon(
              Icons.done,
              color: Colors.blue,
              size: 30,
            ),
            onPressed: () async {
              print("working on submit");
              if (formkey.currentState!.validate()) {
                FirebaseFirestore.instance
                    .collection("forum")
                    .add({
                      'body': save(),
                      'category': category,
                      'likes': 0,
                      'owner': "mgbae22",
                      'owneravatar': "",
                      'title': title,
                      'madeat': DateFormat('yyyy-MM-dd – kk:mm:ss')
                          .format(DateTime.now()),
                      'pinned': false
                    })
                    .then((value) => print("User Added"))
                    .catchError(
                        (error) => print("Failed to add forum: $error"));
                // changeScreenReplancement(
                //     context, ForumPage());
              }
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffEDF1FE),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Form(
            key: formkey,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  /**========================================================================
           **                            TITLE CODE
           *========================================================================**/
                  SizedBox(
                    width: size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Title";
                        }
                      },
                      onChanged: (value) {
                        title = value;
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Enter a title',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        isDense: true,
                      ).copyWith(
                        hintText: 'Title',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                      ),
                    ),
                  ),
                  /*============================ END OF TITLE CODE ============================*/

                  SizedBox(height: 10),
                  /**========================================================================
           **                            LABEL CODE
           *========================================================================**/
                  Container(
                    height: 45,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: category,
                        hint: Text("ADD LABEL"),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 20,
                        elevation: 16,
                        underline: null,
                        dropdownColor: Color(0xffEDF1FE),
                        onChanged: (String? newValue) {
                          setState(() {
                            category = newValue!;
                          });
                        },
                        items: <String>[
                          'ADD LABEL',
                          'IB',
                          'AP',
                          'Phsyics',
                          'Announcement',
                          'Studying',
                          'Suggestions'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                                maxLines: 1),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  /*============================ END OF LABEL CODE ============================*/

                  SizedBox(height: 10),
                  /**========================================================================
           **                            TEXT EDITOR
           *========================================================================**/
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    width: size.width,
                    height: 300,
                    child: Column(
                      children: [
                        ZefyrToolbar.basic(controller: _controller),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      top: BorderSide(color: Colors.grey))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: ZefyrEditor(
                                  controller: _controller,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*============================ END OF TEXT CODE ============================*/

                  SizedBox(height: 10),
                  /**========================================================================
           **                            HASHTAGS COMPLETE CODE
           *========================================================================**/
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      border: Border.all(color: Colors.grey),
                    ),

                    // height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 1, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: SizedBox(
                              height: 20,
                              width: size.width / 2,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Add a hastag...",
                                ),
                                controller: controller,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("hashtags")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return SizedBox(
                                      width: size.width / 1.1,
                                      height: 20,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: snapshot.data!.docs
                                              .map((hashtag) {
                                            if (filter == "" &&
                                                !hashtags
                                                    .contains(hashtag.id)) {
                                              return MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (!hashtags.contains(
                                                            hashtag.id)) {
                                                          hashtags
                                                              .add(hashtag.id);
                                                        }
                                                      });
                                                      print(hashtags);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: SizedBox(
                                                          height: 20,
                                                          child: Text(
                                                              hashtag.id,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .blue),
                                                              maxLines: 1)),
                                                    ),
                                                  ));
                                            } else {
                                              if (hashtag.id
                                                      .toLowerCase()
                                                      .contains(filter
                                                          .toLowerCase()) &&
                                                  !hashtags
                                                      .contains(hashtag.id)) {
                                                return MouseRegion(
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (!hashtags
                                                              .contains(
                                                                  hashtag.id)) {
                                                            hashtags.add(
                                                                hashtag.id);
                                                          }
                                                        });
                                                      },
                                                      child: SizedBox(
                                                          width: 50,
                                                          height: 20,
                                                          child: Text(
                                                              hashtag.id,
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey),
                                                              maxLines: 1)),
                                                    ));
                                              } else {
                                                return Container();
                                              }
                                            }
                                          }).toList()),
                                    );
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            // width: size.width / 1.5,
                            height: 20,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: hashtags
                                    .map((hashtag) => SizedBox(
                                        // width: 0,
                                        height: 10,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (hashtags
                                                      .contains(hashtag)) {
                                                    hashtags.remove(hashtag);
                                                  }
                                                });

                                                print(hashtags);
                                              },
                                              child: Text("#$hashtag",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                  maxLines: 1),
                                            ),
                                          ),
                                        )))
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
                  )
                  /*============================ END OF HASHTAG CODE ============================*/
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
