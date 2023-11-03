import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.infinity,
      width: MediaQuery.of(context).size.width,
      child: Padding(
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
    );
  }
}
