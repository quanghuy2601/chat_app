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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: const Color.fromRGBO(33, 138, 255, 1),
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIconColor: Colors.grey,
                    suffixIconColor: Colors.grey,
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    iconColor: Colors.white,
                    fillColor: const Color.fromRGBO(89, 89, 89, 1),
                    filled: true,
                    hintText: 'Tìm kiếm',
                    hintStyle: const TextStyle(fontSize: 13, color: Color.fromRGBO(233, 235, 238, 1)),
                    // Add a clear button to the search bar
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),

                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
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
                                        Text(
                                          "Tin nhắn mới nhất",
                                          style: TextStyle(
                                            color: Colors.grey,
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
