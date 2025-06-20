import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FBCloudStore {
  static FBCloudStore get instanace => FBCloudStore();
  Future<List<String>?> saveUserDataToFirebaseDatabase(userId, userInfo) async {
    try {
      print("in firestore");
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('chat_id', isEqualTo: userId)
          .get();
      // ignore: unused_local_variable
      final List<DocumentSnapshot> documents = result.docs;
      String myID = userInfo['chat_id'].toString();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userInfo['chat_id'].toString())
          .set(userInfo);
      return [myID];
    } catch (e) {
      return null;
    }
  }

  Future<void> updateMyChatListValues(String userId, String chatID,
      String otherUserId, String typeUpdate) async {
    log('updateMyChatListValues');
    log(userId);
    log(otherUserId);

    var updateData = {
      'badgeCount': 0,
      'chatRoomId': typeUpdate.isEmpty ? otherUserId : "no"
    };
    final DocumentReference result = FirebaseFirestore.instance
        .collection('users')
        .doc(otherUserId)
        .collection('myInbox')
        .doc(chatID);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(result);
      if (!snapshot.exists) {
        final DocumentReference result1 = FirebaseFirestore.instance
            .collection('users')
            .doc(otherUserId)
            .collection('myInbox')
            .doc(chatID);
        transaction.update(result1, updateData);
      } else {
        transaction.update(result, updateData);
      }
    });
  }

  Future updateUserChatListField(
      String otherUserId,
      String lastMessage,
      chatID,
      userId,
      String myName,
      String otherusername,
      String myImg,
      String otherImg,
      String chatroomid,
      ) async {
    var userBadgeCount = 0;
    var isRoom = false;
    // return;
    var other = {
      'chatID': chatID,
      'inboxId': chatroomid,
      'lastChat': lastMessage,
      'badgeCount': isRoom == true ? 0 : userBadgeCount,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'senderName': myName,
      'senderImg': myImg,
      'senderId': userId,
      'reciverId': otherUserId,
      'chatRoomId': "no"
    };
    var myinbox = {
      'chatID': chatID,
      'inboxId': chatroomid,
      'lastChat': lastMessage,
      'badgeCount': isRoom == true ? 0 : userBadgeCount,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'senderName': otherusername,
      'senderImg': otherImg,
      'senderId': otherUserId,
      'reciverId': userId,
      'chatRoomId': "no"
    };
    // ignore: unused_local_variable
    var cardata = {};
    await FirebaseFirestore.instance
        .collection('users')
        .doc(otherUserId)
        .collection('myInbox')
        .doc(chatID)
        .set(other);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('myInbox')
        .doc(chatID)
        .set(myinbox);
  }

  Future sendMessageToChatRoom(
      chatID,
      userId,
      otherUserId,
      content,
      messageType,
      isread,
      String carname,
      String carid,
      String carprice,
      String carphoto,String status) async {
    await FirebaseFirestore.instance
        .collection('chatroom')
        .doc(chatID)
        .collection(chatID)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      'idFrom': userId,
      'idTo': otherUserId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      "carId": carid,
      "carphoto": carphoto,
      "carname": carname,
      "carprice": carprice,
      'content': content,
      'type': messageType,
      'isRead': isread,
      'status':status
    });
  }

//sendnotification
  sendMsgNotification(
      String deviceID,
      String body,
      String title,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    var token = prefs.getString('token');
    final data = {
      "registration_ids": [deviceID],
      "notification": {
        "body": body,
        "title": title,
        // "data": {},
        "android_channel_id": "com.caroh.caro",
        "sound": true
      }
    };
    final url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    final resp = await http.post(url,
        headers: {
          'Authorization':
          "key=AAAA_SmVpCc:APA91bHSkkLlk8ROEEygCJtjtggs0rs8kO0zfrOYMnLy7mugt38ybaMAbHNNSiqlj-9wXVpHY3F5JjvfvilbN1omqvOtjbe7bhIOaA536pOXWWJ-8wzsdxIIbwuCEVsrD0IptdXAGu-N",
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(data));
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      return jsonDecode(resp.body);
    }
  }
}
