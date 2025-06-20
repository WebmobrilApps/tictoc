import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chatdetail.dart';
import 'chatmodel.dart';
import 'firesotre.dart';

class ChatInBox extends StatefulWidget {
  ChatInBox({Key? key});

  @override
  State<ChatInBox> createState() => _ChatInBoxState();
}

class _ChatInBoxState extends State<ChatInBox> {
  FBCloudStore fbCloudStore = FBCloudStore();

  List<ChatRoomModel> dataList = []; // Original data from Firestore
  List<ChatRoomModel> filteredList = []; // Filtered data for display
  String userId = "";
  String userimage = "";
  String username = "";
  bool showpage = false;
  bool isLoading = true; // For loading indicator
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getToken();
    searchController.addListener(() {
      filterSearchResults(searchController.text);
    });
  }

  // Fetch user token and initialize userId
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString("chattoken");
    var jsondata = json.decode(userToken!);

    setState(() {
      userimage = jsondata['userImage'].toString();
      userId = jsondata['chat_id'].toString();
      username = jsondata['username'].toString();
      showpage = true;
    });

    // Load chats after userId is initialized
    fetchChatData();
  }

  // Fetch chat data from Firestore
  fetchChatData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('myInbox')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        dataList = snapshot.docs
            .map((doc) =>
                ChatRoomModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
        filteredList = dataList; // Initially, show all data
        isLoading = false; // Stop loading indicator
      });
    });
  }

  // Filter the search results based on query
  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = dataList; // Reset to full list
      });
    } else {
      setState(() {
        filteredList = dataList
            .where((chat) =>
                (chat.sendername ?? "")
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                (chat.lastMesage ?? "")
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  // Format timestamp
  String returnTimeStamp(messageTimeStamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(messageTimeStamp);
    var now = DateTime.now();
    var todayStart = DateTime(now.year, now.month, now.day);
    var yesterdayStart = todayStart.subtract(const Duration(days: 1));

    if (date.isAfter(todayStart)) {
      return "Today";
    } else if (date.isAfter(yesterdayStart)) {
      return "Yesterday";
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  // Extract first name from full name
  String nameRr(String name) {
    return name.split(" ").first;
  }

  void deleteChat(String? otherUserId) async {
    if (otherUserId == null) return;

    try {
      final inboxRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('myInbox');

      final snapshot = await inboxRef
          .where('senderId', isEqualTo: otherUserId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
        log("Chat deleted with $otherUserId");
      } else {
        log("No matching chat found to delete.");
      }
    } catch (error) {
      log("Failed to delete chat: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AppBar(
            backgroundColor: Colors.yellow,
            elevation: 0,
            centerTitle: true,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: searchController,
                inputFormatters: [],
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  suffixIcon: Image.asset(
                    'assets/images/search2.png',
                    scale: 4,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              )

            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredList.isNotEmpty
              ? ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, i) {
                    ChatRoomModel chatRoomModel = filteredList[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FirebaseChatScreen(
                              otherUserId: chatRoomModel.senderId ?? "",
                              otherUserData: chatRoomModel.senderId ?? "",
                              userId: userId,
                              profileImage: chatRoomModel.senderImg ?? "",
                              userName: chatRoomModel.sendername ?? "",
                              myImage: userimage,
                              name: username,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 1,
                            vertical: 7,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 5),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                width:
                                    MediaQuery.of(context).size.width * 0.148,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: chatRoomModel.senderImg!.isEmpty
                                      ? Image.asset(
                                          "assets/images/profile.png",
                                          fit: BoxFit.cover,
                                        )
                                      : FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/images/profile.png",
                                          imageErrorBuilder: (_, __, ___) {
                                            return Image.asset(
                                              "assets/images/profile.png",
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          image: chatRoomModel.senderImg ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              nameRr(chatRoomModel.sendername.toString()),
                                              style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.start,
                                            )


                                            /*     Padding(
                                              padding: const EdgeInsets.only(top:5),
                                              child: Text(
                                                returnTimeStamp(
                                                    chatRoomModel.timestamp),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )*/
                                          ],
                                        ),
                                        /*TextWidget(
                                            text: "Hi last chat here",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            textAlign: TextAlign.start),*/
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            chatRoomModel.lastMesage ?? "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/images/watch.png', // Path to your image asset
                                              width:
                                                  18, // Adjust width as needed
                                              height:
                                                  18, // Adjust height as needed
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              returnTimeStampp(chatRoomModel.timestamp),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                              textAlign: TextAlign.start,
                                            )

                                          ],
                                        ),
                                        /*  Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            chatRoomModel.lastMesage ?? "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),*/
                                      ],
                                    ),
                                    Spacer(),
                                    PopupMenuButton<String>(
                                      color: Colors
                                          .white, // Set background to white
                                      onSelected: (value) async {
                                        if (value == 'delete') {
                                          deleteChat(chatRoomModel.senderId);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/delete3.png', // Replace with your image path
                                                width: 18,
                                                height: 18,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                "Delete Chat",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.start,
                                              )

                                            ],
                                          ),
                                        ),

                                        /* const PopupMenuDivider(), // Divider
                                                    PopupMenuItem(
                                                      value: 'delete',
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/images/delete3.png', // Replace with your image path
                                                            width: 18,
                                                            height: 18,
                                                          ),
                                                          const SizedBox(width: 8),
                                                          TextWidget(
                                                            text: "Delete Message",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.black,
                                                            textAlign: TextAlign.start,
                                                          ),
                                                        ],
                                                      ),
                                                    ),*/
                                      ],
                                      icon: const Icon(Icons.more_vert),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child:
                  Text(
                 " No Chats Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  )

      ),
    );
  }

  String returnTimeStampp(int? timestamp) {
    if (timestamp == null) return ''; // Handle null case
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('h:mm a').format(dateTime); // Example: 4:14 PM
  }
}
