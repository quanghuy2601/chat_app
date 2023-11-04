import 'dart:convert';

import 'package:chat_app/customUI/my_message.dart';
import 'package:chat_app/customUI/reply_message.dart';
import 'package:chat_app/screens/video_call_screen.dart';
import 'package:chat_app/screens/voice_call_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool sendButton = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(163, 52, 250, 1),
            ),
          );
        }),
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage("assets/avatars/avatar_1.png"),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Trần Quang Huy", //// tên bàn bè
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "Đang hoạt động",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              print("call"); // voice call function
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => VoiceCallScreen(callID: "1")));
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.call,
                color: Color.fromRGBO(163, 52, 250, 1),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("video call"); // video call function
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoCallScreen(callID: "2")));
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.video_camera_front,
                color: Color.fromRGBO(163, 52, 250, 1),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              //height: MediaQuery.of(context).size.height - 140,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1, //// số lượng tin nhắn
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    /// truyền tin nhắn đến các thẻ tin nhắn
                    children: [
                      MyMessage(),
                      ReplyMessage(),
                      //
                    ],
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Card(
                            margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: _messageController,
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    sendButton = true;
                                  });
                                } else {
                                  sendButton = false;
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Aa",
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    focusNode.unfocus();
                                    focusNode.canRequestFocus = false;
                                    setState(() {
                                      //
                                    });
                                  },
                                  icon: const Icon(Icons.emoji_emotions_outlined),
                                ),
                                contentPadding: const EdgeInsets.all(5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: const Color.fromRGBO(163, 52, 250, 1),
                            child: IconButton(
                              onPressed: () {
                                if (sendButton) {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                  // send message function
                                  _messageController.clear();
                                  setState(() {
                                    sendButton = false;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getListMessage() async {
    try {
      final url = Uri.parse('http://10.15.38.139:5000/api//model/message'); // api lấy danh sách tin nhắn

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          //
        }),
      );

      if (response.statusCode == 200) {
        //return true;
      } else {
        //return false;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  void _sendMessage(String message) {
    //
  }
}
