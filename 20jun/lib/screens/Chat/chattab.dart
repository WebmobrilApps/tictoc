import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatInbox.dart';
import 'chatdetail.dart';
import 'chatmodel.dart';
import 'firesotre.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({
    Key? key,
  }) : super(key: key);
  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> with TickerProviderStateMixin {
  FBCloudStore fbCloudStore = FBCloudStore();
  final TextEditingController searchController = TextEditingController();

  dynamic dataList = [];
  String userId = '';
  String userimage = "";
  String username = "";
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString("chattoken");
    log("this is usertoken $userToken");
    var jsondata = json.decode(userToken!);
    var chatId = jsondata['chat_id'];
    setState(() {
      userimage = jsondata['userImage'].toString();
      userId = chatId;
      username = jsondata['username'].toString();
    });

    log("userId");
    log(userId);
    log(username);
  }

  List<dynamic> MyUserData = [];
  Timer? timer;
  @override
  void initState() {
    getToken();
    // log("${1.w}hello");
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    // 'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    // 'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];
  List recenttext = [];
  String nameRr(String name) {
    String text = name.split(" ").first;
    return text;
  }

  int selectedIndex = 0;
  List appbartitle = [];
  List appbarIcon = [
    Icons.lightbulb_circle_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(child: ChatInBox()),
    );
  }

  Widget genaralChatList() {
    return userId.isNotEmpty
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('myInbox')
                .orderBy('timestamp', descending: true)
                // .where("18969-$userId", isEqualTo: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
              log("jjjlenght======${snap.data?.docs.length}");
              if (snap.connectionState == ConnectionState.active) {
                if (snap.hasData) {
                  QuerySnapshot chatRoomSnapshot = snap.data as QuerySnapshot;
                  return ListView.builder(
                      itemCount: chatRoomSnapshot.docs.length,
                      itemBuilder: (context, i) {
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                            chatRoomSnapshot.docs[i].data()
                                as Map<String, dynamic>);
                        return GestureDetector(
                          onTap: () {
                            print("12345");
                            print(userId + "check");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => FirebaseChatScreen(
                                        otherUserId: chatRoomModel.senderId ?? "",
                                        otherUserData: chatRoomModel.senderId ?? "",
                                        userId: userId,
                                        profileImage: userimage,
                                        userName:
                                            chatRoomModel.sendername ?? "",
                                        myImage: chatRoomModel.senderImg ?? "",
                                        name: username)));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 5,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 14,
                                  width: 14,
                                  /*  chat.unread!  */
                                  decoration: /* chat.unread */
                                      const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: chatRoomModel.senderImg!.isEmpty
                                          ? const Icon(Icons.person, size: 40)
                                          : FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/carrohh.png',
                                              imageErrorBuilder:
                                                  (_, Object, StackTrace) {
                                                return const Icon(Icons.person,
                                                    size: 40);
                                              },
                                              image:
                                                  chatRoomModel.senderImg ?? "",
                                              fit: BoxFit.cover,
                                              // height: 250.0,
                                            ) /* Image.network(
                                              chatRoomModel.senderImg ?? "") */
                                      ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                  width: 90,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            chatRoomModel.sendername
                                                .toString()
                                                .toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                            //chatRoomModel.sendername.toString().capitalized,
                                          ),
                                          Text(
                                            returnTimeStamp(
                                                chatRoomModel.timestamp),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade200),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          chatRoomModel.lastMesage ?? "",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (snap.hasError) {
                  return Center(
                    child: Text("Someerroroccurred"),
                  );
                } else {
                  return Center(
                    child: Text("Nochatavailable"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
        : const SizedBox();
  }

  String returnTimeStamp(messageTimeStamp) {
    log(messageTimeStamp.toString());

    String resultString = '';
    var date = DateTime.fromMillisecondsSinceEpoch(messageTimeStamp);
    var now = DateTime.now();
    var todayStart = DateTime(now.year, now.month, now.day); // Start of today
    var yesterdayStart =
        todayStart.subtract(const Duration(days: 1)); // Start of yesterday

    if (date.isAfter(todayStart)) {
      print("today");
      // If the timestamp is after the start of today
      resultString = "Today";
    } else if (date.isAfter(yesterdayStart) && date.isBefore(todayStart)) {
      print("yesterday");
      // If the timestamp is between yesterday's start and today's start
      resultString = "Yesterday";
    } else {
      print("perticular date");
      // For all other days, format as dd/MM/yyyy
      resultString = DateFormat('dd/MM/yyyy').format(date);
    }

    return resultString;
  }
}

void doNothing2(BuildContext context, String username) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Text(username),
      );
    },
  );
}
