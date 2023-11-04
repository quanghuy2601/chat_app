import 'dart:convert';

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/utils/user.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ListChatScreen> {
  bool isPressed = false;

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.infinity,
      width: MediaQuery.of(context).size.width,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(8.0)),
            SizedBox(
              height: 100,
              child: Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: users.length, ///////// số lượng cuộc trò chuyện
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(users[index].avatar),
                          radius: 35,
                          child: users[index].isOnline
                              ? const Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      );
                    }),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  //padding: const EdgeInsets.all(10),
                  itemCount: users.length, ////////// số lượng cuộc trò chuyện
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // mở cuộc trò chuyện

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ChatScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage(users[index].avatar),
                                  radius: 35,
                                  child: users[index].isOnline
                                      ? const Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 16,
                                                  backgroundColor: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : null,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 105,
                                    height: 70,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          users[index].name, ////// tên bàn bè
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _getListConversation() async {
    try {
      final url = Uri.parse('http://10.15.38.139:5000/api/model/conversation'); // api lấy danh sách cuộc trò chuyện

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
}
