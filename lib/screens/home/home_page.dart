// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lessunapp/screens/home/feedpostdetail.dart';
import 'package:lessunapp/services/auth_service.dart';
import 'package:lessunapp/widgets/homefeed_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filter = "";
  String searchFilter = "";
  TextEditingController searchController = TextEditingController();
  bool? loading = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    //fill countries with objects
    searchController.addListener(() {
      setState(() {
        searchFilter = searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('LESSUN',
            style: TextStyle(
                color: Colors.indigo[900], fontWeight: FontWeight.w900)),
        centerTitle: false,
        backgroundColor: Color(0xffEDF1F5),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.post_add, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, "/makePostPage");
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              await AuthService().logoutUser();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/authPage", (route) => false);
              setState(() {
                loading = false;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () async {
              // String? uid = await LocalStore.getUid("uid");
              // print(uid);

              Navigator.pushNamed(context, "/profilePage");
            },
          ),
        ],
      ),
      backgroundColor: Color(0xffEDF1FE),
      body: loading == true
          ? CircularProgressIndicator()
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: size.height * 0.07,
                              // width: size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 0),
                              margin: EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              child: TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  labelText: 'Start typing',
                                  // hintText: 'Start typing',
                                  suffixIcon: Icon(Icons.search),
                                  suffixIconConstraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                  //border
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              var value = await Navigator.pushNamed(
                                  context, "/filterPage");

                              print(value.toString());
                              setState(() {
                                filter = value.toString();
                              });
                            },
                            child: Icon(
                              Icons.filter_alt_outlined,
                              size: 40,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
/**========================================================================
 **                            Code for Feed Post from firebase
 *========================================================================**/

                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("forum")
                            .orderBy("pinned", descending: true)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            return Expanded(
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: snapshot.data!.docs.map((forum) {
                                  if (forum["title"]
                                      .toUpperCase()
                                      .contains(searchFilter.toUpperCase())) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          print(forum["likes"]);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FeedPostDetailPage(
                                                body: forum["body"],
                                                category: forum["category"],
                                                likes: forum["likes"],
                                                owner: forum["owner"],
                                                owneravatar:
                                                    forum["owneravatar"],
                                                title: forum["title"],
                                                madeat: forum["madeat"],
                                                id: forum.id,
                                                replyCount: forum["replyCount"],
                                                // ifLiked: false,
                                                ifPined: forum["pinned"],
                                                // likeCount: 0,
                                              ),
                                            ),
                                          );
                                        },
                                        child: HomeFeedPost(
                                          id: forum.id,
                                          title: forum["title"],
                                          category: forum["category"],
                                          userImg: "",
                                          ifPined: forum["pinned"],
                                          likes: forum["likes"],
                                          replyCount: forum["replyCount"],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center();
                                  }
                                }).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
