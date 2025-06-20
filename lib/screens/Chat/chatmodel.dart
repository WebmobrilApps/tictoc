class ChatRoomModel {
  String? senderId;
  String? recevierId;
  String? lastMesage;
  int? badgeCount;
  String? senderImg;
  String? sendername;
  String? chatID;
  int? timestamp;
  ChatRoomModel(
      {this.senderId,
        this.recevierId,
        this.lastMesage,
        this.badgeCount,
        this.senderImg,
        this.chatID});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    badgeCount = map["badgeCount"];
    chatID = map["chatID"];
    lastMesage = map["lastChat"];
    recevierId = map["recevierId"];
    sendername = map["senderName"];
    senderId = map["senderId"];
    senderImg = map["senderImg"];
    timestamp = map["timestamp"];
  }

  Map<String, dynamic> toMap() {
    return {
      'badgeCount': badgeCount,
      'chatID': chatID,
      'chatRoomId': "no",
      'lastChat': lastMesage,
      'recevierId': recevierId,
      'senderName': sendername,
      'senderId': senderId,
      'senderImg': senderImg,
      'timestamp': timestamp,


    };
  }
}

class MyInbox {
  String? senderId;
  String? recevierId;
  String? lastMesage;
  int? badgeCount;
  String? senderImg;
  String? chatID;
  String? inboxId;
  String? senderName;
  int? timestamp;

  Map<String, dynamic> toMap() {
    return {
      'badgeCount': badgeCount,
      'chatID': chatID,
      'chatRoomId': "no",
      'inboxId': inboxId,
      'lastChat': lastMesage,
      'recevierId': recevierId,
      'senderId': senderId,
      'senderImg': senderImg,
      'senderName': senderName,
      'timestamp': timestamp,
    };
  }
}