import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/utils/user.dart';
import 'package:flutter/material.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ListChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isPressed = false;
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
                    //padding: const EdgeInsets.all(10),
                    itemCount: users.length,
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
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
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
                                          users[index].name,
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
}
