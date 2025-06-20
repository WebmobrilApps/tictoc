import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictoc/cubit/tictoc_cubit.dart';
import 'package:tictoc/model/get_other_profile_response.dart';
import 'package:tictoc/utils/custom_loader.dart';
import 'package:tictoc/utils/error_display.dart';
import 'package:video_player/video_player.dart';
import '../../utils/color.dart';
import '../../utils/constants.dart';
import '../../utils/custom_navigator.dart';
import '../../utils/custom_widgets.dart';
import '../../utils/ui_helper.dart';
import '../inbox/other_profile_menu.dart';
import 'chattab.dart';
import 'firesotre.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'dart:convert';

int roomId = 0;

class FirebaseChatScreen extends StatefulWidget {
  final String name;
  final String myImage;
  final String userId;
  final String otherUserId;
  final String profileImage;
  final String userName;
  final String otherUserData;


  const FirebaseChatScreen({
    super.key,
    required this.otherUserId,
    required this.otherUserData,
    required this.userId,
    required this.profileImage,
    required this.userName,
    required this.myImage,
    required this.name,
  });

  @override
  State<FirebaseChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<FirebaseChatScreen> {
  String userName = "";
  bool showLoader = true;
  FBCloudStore fbCloudStore = FBCloudStore();
  TextEditingController msgController = TextEditingController();
  GetOtherProfileResponse getOtherProfileResponse = GetOtherProfileResponse();
  final _scrollController = ScrollController();
  String chatId = "";
  String imageUrl = "";
  var setroom;
  var roomid;
  String devicetokenofothermer = "";
  String otherusername = " ";
  String otheruserId = " ";
  final ImagePicker _picker = ImagePicker();
  bool _emojiShowing = false;

  bool showEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  String token = "";
  @override
  void initState() {
    _getOtherProfileAPi();
    _loadData();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          _emojiShowing = false;
        });
      }
    });

    if (int.parse(widget.userId) > int.parse(widget.otherUserId)) {
      setroom = '${widget.userId}-${widget.otherUserId}';
      roomid = widget.userId + widget.otherUserId;
      setState(() {
        roomId = int.parse(roomid);
      });
    } else {
      setroom = '${widget.otherUserId}-${widget.userId}';
      roomid = widget.otherUserId + widget.userId;
      setState(() {
        roomId = int.parse(roomid);
      });
    }
    fbCloudStore.updateMyChatListValues(
        widget.userId, setroom, widget.otherUserId, "");
    // messageCountUpdtae();

    super.initState();
  }

  Future<void> _getOtherProfileAPi() async {
    await BlocProvider.of<TicTocCubit>(context).otherProfileCall(widget.otherUserData);
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('usertoken') ?? '';
    });
  }

  List<dynamic> addInstructionInSnapshot(List<QueryDocumentSnapshot> snapshot) {
    List<dynamic> _returnList;
    List<dynamic> _newData = addChatDateInSnapshot(snapshot);
    _returnList = List<dynamic>.from(_newData.reversed);

    return _returnList;
  }

  List<dynamic> addChatDateInSnapshot(List<QueryDocumentSnapshot> snapshot) {
    List<dynamic> _returnList = [];
    String _currentDate = "";

    for (QueryDocumentSnapshot snapshot in snapshot) {
      var format = DateFormat('EEEE, MMMM d, yyyy');
      var date = DateTime.fromMillisecondsSinceEpoch(snapshot['timestamp']);

      // ignore: unnecessary_null_comparison
      if (_currentDate == null) {
        _currentDate = format.format(date);
        _returnList.add(_currentDate);
      }

      if (_currentDate == format.format(date)) {
        _returnList.add(snapshot);
      } else {
        _currentDate = format.format(date);
        _returnList.add(_currentDate);
        _returnList.add(snapshot);
      }
    }

    return _returnList;
  }

  sendMessageFunction(String type, {String imageUrl = ""}) async {
    var count = 0;
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.otherUserId)
        .get()
        .then((value) {
      setState(() {
        devicetokenofothermer = value['deviceToken'];
        otherusername = value['userName'];
        otheruserId = value['user_id'];
        log(value['deviceToken'] + "     samne vale ka device token");
      });
    });

    if (type == "image" && imageUrl.isNotEmpty) {
      setState(() {
        fbCloudStore.sendMessageToChatRoom(
            setroom,
            widget.userId,
            widget.otherUserId,
            imageUrl.isNotEmpty
                ? imageUrl
                : msgController.text.toString().trim(),
            type,
            false,
            "",
            "",
            "",
            "",
            "sent");

        msgController.clear();
        imageUrl = "";
      });
    } else {
      if (msgController.text.isNotEmpty && msgController.text != " ") {
        setState(() {
          fbCloudStore.sendMessageToChatRoom(
              setroom,
              widget.userId,
              widget.otherUserId,
              imageUrl.isNotEmpty
                  ? imageUrl
                  : msgController.text.toString().trim(),
              type,
              false,
              "",
              "",
              "",
              "",
              "sent");
          fbCloudStore.updateUserChatListField(
            widget.otherUserId,
            imageUrl.isNotEmpty ? "Photo" : msgController.text.toString(),
            setroom,
            widget.userId,
            widget.name,
            widget.userName,
            widget.myImage,
            widget.profileImage,
            setroom,
          );
          msgController.clear();
          imageUrl = "";
        });
      }
    }
  }

  Future<String> uploadImageToFirebase(String filePath) async {
    print(filePath);
    print("Amit");
    final fileName = filePath.split('/').last;
    final firebaseStorageRef =
        FirebaseStorage.instance.ref().child('chat_images/$fileName');
    final uploadTask = firebaseStorageRef.putFile(File(filePath));

    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  void toggleEmojiPicker() {
    FocusScope.of(context).unfocus(); // Hide keyboard
    setState(() {
      _emojiShowing = !_emojiShowing;
    });
  }

  bool isTyping = false;
  bool isSelectionMode = false;
  List<String> selectedMessageIds = [];


  List<QueryDocumentSnapshot> allChats = [];

  void handleMessageLongPress(String id) {
    setState(() {
      isSelectionMode = true;
      selectedMessageIds.add(id);
    });
  }

  void handleMessageTap(String id) {
    setState(() {
      if (selectedMessageIds.contains(id)) {
        selectedMessageIds.remove(id);
        if (selectedMessageIds.isEmpty) {
          isSelectionMode = false;
        }
      } else {
        selectedMessageIds.add(id);
      }
    });
  }
  void deleteSelectedChats() async {
    if (selectedMessageIds.isEmpty) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Chats',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          content: Text(
            'Are you sure you want to delete the selected chats?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    // Firestore deletion logic
    for (var messageId in selectedMessageIds) {
      try {
        await FirebaseFirestore.instance
            .collection('chatroom') // Main chatroom collection
            .doc(setroom) // The specific chatroom
            .collection(setroom) // Messages within the room
            .doc(messageId) // The specific message to delete
            .delete(); // Deleting the message
      } catch (e) {
        print("Error deleting message: $e");
      }
    }

    setState(() {
      print("Deleted message IDs:");
      print(selectedMessageIds);

      // Remove deleted chats from your local list
      allChats.removeWhere((chat) => selectedMessageIds.contains(chat.id));
      selectedMessageIds.clear(); // Clear the selected messages list
      isSelectionMode = false; // Exit selection mode
    });

    /* ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Selected chats deleted")),
  ); */
  }





  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(68), // Set the desired height
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xffF2F2F2),
            elevation: 0.0,
            centerTitle: true,
            flexibleSpace: showLoader==true?const SizedBox():Padding(
              padding: const EdgeInsets.only(top: 50.0), // Adjust padding for vertical alignment
              child: Row(
                children: [
                  UiHelper.horizontalSpace(width: 6),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Image.asset(
                      "assets/images/back_arrow_black.png",
                      height: 28,
                      width: 28,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 21, // Controls the overall size of the avatar
                          backgroundColor: appBlackColor,// Border color
                          child: cachedImageWidget(
                              image:"$BASEURL/${getOtherProfileResponse.data?.profilePic??''}",
                              borderRadiusValue:20,
                              hasProfileImg:true,
                              height: 50,width: 50),
                        ),
                        //const SizedBox(width: 8),
                        //Image.asset('assets/images/inbox2.png', height: 40, width: 40),
                        const SizedBox(width: 8),
                        Flexible(
                          child: mediumText14(
                            context,
                            getOtherProfileResponse.data?.name??'',
                     //       otherProfileData!.name.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            maxLines: 1,
                            textColor: appBlackColor,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      CustomNavigator.push(context: context, screen: const OtherProfileMenu());
                    },
                    icon: Image.asset(
                      "assets/images/more_horiz.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  UiHelper.horizontalSpace(width: 18),
                ],
              ),
            ),
          ),
        ),
      //  extendBodyBehindAppBar: true,
        body: BlocConsumer<TicTocCubit,TicTocState>(
          listener: (context,state){
            print("sate.status:${state.status}");
            if(state.status == TicTocStatus.getOtherProfileSuccess){
                setState(() {
                  showLoader = false;
                });
              getOtherProfileResponse = state.responseData?.response as GetOtherProfileResponse;
            }
          },
          builder: (context,state){
            if (showLoader == true || state.status == TicTocStatus.getOtherProfileLoading) {
              return const CustomLoader();
            }
            if (state.status == TicTocStatus.getOtherProfileError) {
              return CustomErrorWidget(
                errorMessage: state.errorData?.message ?? state.error,
                statusCode: state.errorData?.code,
                onRetry: refreshPage,
                onRefresh: refreshPage,
              );
            }
            return  Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              UiHelper.verticalSpace(height: 18),
                              CircleAvatar(
                                radius: 40, // Controls the overall size of the avatar
                                backgroundColor: appBlackColor,// Border color
                                child: cachedImageWidget(
                                    image:"$BASEURL/${getOtherProfileResponse.data?.profilePic??''}",
                                    borderRadiusValue:50,
                                    hasProfileImg:true,
                                    height: 78,width: 78),
                              ),

                              //   Image.asset('assets/images/inbox2.png', height: 80, width: 80),
                              UiHelper.verticalSpace(height: 6),
                              mediumText14(context, getOtherProfileResponse.data?.name??''),
                              mediumText14(context, '@${getOtherProfileResponse.data?.username}',textColor: const Color(0xff484848)),
                              UiHelper.verticalSpace(height: 6),
                              Row( mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  mediumText14(context, '@${getOtherProfileResponse.data?.following} following ',textColor: const Color(0xff484848)),
                                  mediumText14(context, '@${getOtherProfileResponse.data?.followers} followers',textColor: const Color(0xff484848)),
                                ],
                              ),
                              UiHelper.verticalSpace(height: 12),
                              //  smallText12(context, getCurrentTime(),textColor: const Color(0xff484848)),

                            ],
                          ),
                        ),
                        messagesListview(),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4), // gives a 3D lift effect
                        ),
                      ],
                    ),
                    child: TextField(
                      focusNode: focusNode,
                      controller: msgController,
                      minLines: 1,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.black), // ✅ Text color black
                      onChanged: (text) {
                        setState(() {
                          isTyping = text.trim().isNotEmpty;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  _emojiShowing = !_emojiShowing;
                                });
                              },
                              icon: const Icon(Icons.emoji_emotions_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                if (msgController.text.trim().isNotEmpty) {
                                  sendMessageFunction("text");
                                }
                              },
                              icon: Image.asset(
                                'assets/images/share_grey.png',
                                height: 30,
                                width: 30,
                                color: isTyping ? Colors.blue : null,
                              ),
                            ),
                          ],
                        ),
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                captureFromCamera();
                              },
                              child: Transform.scale(
                                scale: 1.1,
                                child: Image.asset(
                                  'assets/images/camera_pink.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                picImage();
                              },
                              child: Transform.scale(
                                scale: 0.9,
                                child: Image.asset(
                                  'assets/images/gallery_grey.png',
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                        hintText: " Send a message",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none, // ❌ Remove borders
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                    ),
                  ),
                ),


                // Emoji Picker should be outside TextField container
                if (_emojiShowing)
                  Offstage(
                    offstage: !_emojiShowing,
                    child: SizedBox(
                      height: 256,
                      child: EmojiPicker(
                        textEditingController: msgController,
                        scrollController: _scrollController,
                        config: Config(
                          height: 256,
                          checkPlatformCompatibility: true,
                          viewOrderConfig: const ViewOrderConfig(),
                          emojiViewConfig: EmojiViewConfig(
                            emojiSizeMax: 28 *
                                (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                    ? 1.2
                                    : 1.0),
                          ),
                          skinToneConfig: const SkinToneConfig(),
                          categoryViewConfig: const CategoryViewConfig(),
                          bottomActionBarConfig:
                          const BottomActionBarConfig(enabled: false),
                          searchViewConfig: SearchViewConfig(),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        )
    );
  }

  Future<void> refreshPage() async{
    setState(() {
      //  showLoader = true;
    });
    await _getOtherProfileAPi();
  }

  void markMessageAsDelivered(String messageId) {
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(setroom)
        .collection(setroom)
        .doc(messageId)
        .update({'status': 'delivered'});
  }

  void markMessageAsSeen(String messageId) {
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(setroom)
        .collection(setroom)
        .doc(messageId)
        .update({'status': 'seen'});
  }

  Widget messagesListview() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chatroom")
            .doc(setroom)
            .collection(setroom)
            .orderBy('timestamp')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            allChats = snapshot.data!.docs;
            return ListView(
                shrinkWrap: true,
                reverse: true,
                physics:NeverScrollableScrollPhysics(),
                children: addInstructionInSnapshot(snapshot.data!.docs)
                    .map(_returnChatWidget)
                    .toList());
          }
          return const SizedBox();
        });
  }


  Widget _returnChatWidget(dynamic data) {
    if (data is QueryDocumentSnapshot) {
      final docMap = data.data() as Map<String, dynamic>;
      final messageId = data.id;
      final status = docMap['status'] as String? ?? 'sent';

      // Handle delivery/seen for other user messages
      if (docMap['idFrom'] == widget.otherUserId) {
        if (status == 'sent') {
          markMessageAsDelivered(messageId);
        } else if (status == 'delivered') {
          markMessageAsSeen(messageId);
        }
      }

      return docMap['idFrom'] == widget.otherUserId
          ? peerUserListTile(
        context,
        docMap['content'],
        returnTimeStamp(docMap['timestamp']),
        docMap['type'],
        docMap['carname'],
        docMap['carId'].toString(),
        docMap['carprice'],
        docMap['isRead'],
        docMap['carphoto'],
          messageId: messageId,
          isSelectionMode: isSelectionMode,
          isSelected: selectedMessageIds.contains(messageId),
          onMessageLongPress: handleMessageLongPress,
          onMessageTap: handleMessageTap
      )
          : mineListTile(
        context,
        docMap['content'],
        returnTimeStamp(docMap['timestamp']),
        docMap['type'],
        docMap['timestamp'].toString(),
        docMap['isRead'],
        docMap['carname'],
        docMap['carId'].toString(),
        docMap['carprice'],
        docMap['carphoto'],
        status,
        messageId: messageId,
        isSelectionMode: isSelectionMode,
        isSelected: selectedMessageIds.contains(messageId),
        onMessageLongPress: handleMessageLongPress,
        onMessageTap: handleMessageTap,
      );
    } else if (data is String) {
      return stringListTile(data);
    } else {
      return const SizedBox(); // fallback
    }
  }

  Widget stringListTile(String data) {
    Widget _returnWidget;

    _returnWidget = Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.grey[200]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
            child: Text(
              data,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ),
    );

    return _returnWidget;
  }

  String returnTimeStamp(int messageTimeStamp) {
    String resultString = '';
    var format = DateFormat('hh:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(messageTimeStamp);
    resultString = format.format(date);
    return resultString;
  }

  Widget peerUserListTile(
    BuildContext context,
    String message,
    String time,
    String type,
    String carname,
    String carid,
    String carprice,
    bool readUnread,
    String carphoto,
      {
        required String messageId, // New parameter
        required bool isSelectionMode, // New parameter
        required bool isSelected, // New parameter
        required Function(String) onMessageLongPress, // New parameter
        required Function(String) onMessageTap, // New parameter
      }
  ) {
    void markAsRead() {
      setState(() {
        readUnread = true; // Mark as read when tapped
      });
    }

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: GestureDetector(
        onTap: markAsRead,
        child: Container(
          child: GestureDetector(
            onLongPress: () => onMessageLongPress(messageId),
            onTap: () => isSelectionMode ? onMessageTap(messageId) : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(color: Colors.red, width: 1)
                              : null,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 2, 4, 4),
                              child: type == 'text'
                                  ? Container(
                                      constraints: BoxConstraints(
                                        maxWidth: size.width * 0.85,
                                        minWidth: size.width * 0.15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        gradient: LinearGradient(
                                            colors: [Colors.pink.shade200, Colors.pink.shade100]),                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          message,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.start,
                                        )

                                      ),
                                    )
                                  : type == 'image' &&
                                          !message.toLowerCase().endsWith('.mp4')
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.network(
                                              message,
                                              height: 250,
                                              width: 260,
                                              fit: BoxFit.cover,
                                              filterQuality: FilterQuality.high,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return SizedBox(
                                                  height: 180,
                                                  width: 260,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.blue,
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress
                                                                      .expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const SizedBox(
                                                  height: 180,
                                                  width: 260,
                                                  child: Center(
                                                      child: Icon(
                                                          Icons.broken_image,
                                                          size: 40)),
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                      : message.toLowerCase().endsWith('.mp4')
                                          ? SizedBox(
                                              height: 250,
                                              width: 260,
                                              child: VideoPlayerScreen(
                                                  videoUrl: message),
                                            )
                                          : const Text('Unsupported media format'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14.0, left: 4),
                        child: Text(
                          time,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mineListTile(
    BuildContext context,
    String message,
    String time,
    String type,
    String timesamp,
    bool readUnread, // Keep this as a parameter
    String carname,
    String carid,
    String carprice,
    String carphoto,
    String status, {
    required String messageId, // New parameter
    required bool isSelectionMode, // New parameter
    required bool isSelected, // New parameter
    required Function(String) onMessageLongPress, // New parameter
    required Function(String) onMessageTap, // New parameter
  }) {
    final size = MediaQuery.of(context).size;

    // Update the state when the message is tapped or seen (mark as read)
    void markAsRead() {
      setState(() {
        readUnread = true; // Set readUnread to true when the message is seen
      });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onLongPress: () => onMessageLongPress(messageId),
            onTap: () => isSelectionMode ? onMessageTap(messageId) : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(color: Colors.red, width: 1)
                        : null,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3, 2, 4, 4),
                        child: type == 'text'
                            ? Container(
                                constraints: BoxConstraints(
                                    maxWidth: size.width - size.width * 0.28),
                                decoration: BoxDecoration(
                                  color: type == 'text'
                                      ? Colors.grey[100]
                                      : Colors.transparent,
                                  gradient: LinearGradient(
                                      colors: [Colors.pink.shade200, Colors.pink.shade100]),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                    bottomLeft: Radius.circular(25.0),
                                    bottomRight: Radius.circular(0),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(type == 'text' ? 10.0 : 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        message,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                      )

                                    ],
                                  ),
                                ),
                              )
                            : type == 'image' &&
                                    !message.toLowerCase().endsWith('.mp4')
                                ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.network(
                                        message,
                                        height: 250,
                                        width: 260,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return SizedBox(
                                            height: 180,
                                            width: 260,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.pink,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const SizedBox(
                                            height: 180,
                                            width: 260,
                                            child: Center(
                                                child: Icon(
                                                    Icons.broken_image,
                                                    size: 40)),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : message.toLowerCase().endsWith('.mp4')
                                    ? SizedBox(
                                        height: 250,
                                        width: 260,
                                        child: VideoPlayerScreen(
                                            videoUrl: message),
                                      )
                                    : const Text('Unsupported media format'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 4),
              if (status == 'sent') ...[
                Icon(Icons.check, size: 16, color: Colors.grey),
              ] else if (status == 'delivered') ...[
                Icon(Icons.done_all, size: 16, color: Colors.grey),
              ] else if (status == 'seen') ...[
              //  Icon(Icons.done_all, size: 16, color: Colors.blue),
                Row(
                  children: [
                    Image.asset('assets/images/seen.png',height: 20,width: 20,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10,right: 6,left: 2),
                      child: smallText12(context, 'Sent',textColor: Color(0xff484848)),
                    ),
                  ],
                )
              ],
            ],
          )
        ],
      ),
    );
  }

  Widget messageStatusIcon(String status) {
    switch (status) {
      case 'sent':
        return Icon(Icons.check, size: 16, color: Colors.grey);
      case 'delivered':
        return Icon(Icons.done_all, size: 16, color: Colors.grey);
      case 'seen':
        return Icon(Icons.done_all, size: 16, color: Colors.blue);
      default:
        return Container();
    }
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = '${diff.inHours} hour ago';
      } else if (diff.inMinutes > 0) {
        time = '${diff.inMinutes} min ago';
      } else if (diff.inSeconds > 0) {
        time = 'now';
      } else if (diff.inMilliseconds > 0) {
        time = 'now';
      } else if (diff.inMicroseconds > 0) {
        time = 'now';
      } else {
        time = 'now';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = '${diff.inDays} days ago';
    } else if (diff.inDays > 6) {
      time = '${(diff.inDays / 7).floor()} week ago';
    } else if (diff.inDays > 29) {
      time = '${(diff.inDays / 30).floor()} month ago';
    } else if (diff.inDays > 365) {
      time = '${date.month}-${date.day}-${date.year}';
    }
    return time;
  }


  Future captureFromCamera() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Capture Image'),
                onTap: () async {
                  Navigator.of(context).pop(); // Close sheet
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      uploadeImages(image.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Capture Video'),
                onTap: () async {
                  Navigator.of(context).pop(); // Close sheet
                  final video =
                      await ImagePicker().pickVideo(source: ImageSource.camera);
                  if (video != null) {
                    setState(() {
                      uploadeImages(video.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future picImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Pick Image'),
                onTap: () async {
                  Navigator.of(context).pop(); // Close sheet
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      uploadeImages(image.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Pick Video'),
                onTap: () async {
                  Navigator.of(context).pop(); // Close sheet
                  final video = await ImagePicker()
                      .pickVideo(source: ImageSource.gallery);
                  if (video != null) {
                    setState(() {
                      uploadeImages(video.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void uploadeImages(String path) async {
    print("Token");
    print(token);
    showAlertDialog(context);

    final uri = Uri.parse(BASEURL + "user/upload-image");

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('file', path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final responseData = json.decode(respStr);

      if (responseData['success'] == true) {
        final imageUrl = responseData['data'];

        setState(() {
          this.imageUrl = imageUrl;
          sendMessageFunction("image", imageUrl: imageUrl);
          Navigator.of(context).pop();
        });

        log(imageUrl.toString());
      } else {
        Navigator.of(context).pop();
        log("Upload failed: ${responseData['message']}");
      }

    } else {
      Navigator.of(context).pop();
      log("Failed to upload image. Status code: ${response.statusCode}");
    }
  }

  void getImageLink(String baseName) async {
    final uri =
        Uri.parse("http://186.190.215.109:10057/api/v1/user/upload-image");

    // You can send multipart request if you're uploading a file, assuming `baseName` is the file path
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', baseName));

    final response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final responseData = json.decode(respStr);

      if (responseData['success'] == true) {
        final imageUrl = responseData['data'];

        setState(() {
          this.imageUrl = imageUrl;
          sendMessageFunction("image", imageUrl: imageUrl);
          Navigator.of(context).pop();
        });

        log(imageUrl.toString());
      } else {
        log("Upload failed: ${responseData['message']}");
      }
    } else {
      log("Failed to upload image. Status code: ${response.statusCode}");
    }
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black38,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void deleteMessages(id) {
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(setroom)
        .collection(setroom)
        .doc(id)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("DeletedSucessfully")));
    log(">>>>>>>>>>>>>>>>>>>>> Message Deleted");
    log(">>>>>>>>>>>>>>>>>>>>>${id}");
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        // Don't autoplay — keep it paused by default
      });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
    super.deactivate();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });

    // Optional: auto-hide controls after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                _showControls = !_showControls;
              });
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                final videoHeight =
                    constraints.maxWidth / _controller.value.aspectRatio;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      height: videoHeight,
                      child: VideoPlayer(_controller),
                    ),
                    if (_showControls)
                      IconButton(
                        iconSize: 64,
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: Colors.white,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                  ],
                );
              },
            ),
          )
        : Center(child: CircularProgressIndicator(color: Colors.pink));
  }


}

Future<void> deleteChatroom(String roomId) async {
  final chatCollection = FirebaseFirestore.instance
      .collection('chatroom')
      .doc(roomId)
      .collection(roomId);

  final batch = FirebaseFirestore.instance.batch();

  final messages = await chatCollection.get();
  for (var doc in messages.docs) {
    batch.delete(doc.reference);
  }

  await batch.commit();
}
