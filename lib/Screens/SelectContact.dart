import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/CustomUI/ContactCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/CreateGroup.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(name: "Dev Stack", status: "A full stack developer"),
      ChatModel(name: "Balram", status: "Flutter Developer..........."),
      ChatModel(name: "Saket", status: "Web developer..."),
      ChatModel(name: "Bhanu Dev", status: "App developer...."),
      ChatModel(name: "Collins", status: "React developer.."), // Fixed spelling
      ChatModel(name: "Kishor", status: "Full Stack Web"),
      ChatModel(name: "Testing1", status: "Example work"),
      ChatModel(name: "Testing2", status: "Sharing is caring"),
      ChatModel(name: "Divyanshu", status: "....."),
      ChatModel(name: "Helper", status: "Love you Mom Dad"),
      ChatModel(name: "Tester", status: "I find the bugs"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "256 contacts",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 26,
            ),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) { // Fixed context spelling
              return [
                const PopupMenuItem(
                  value: "Invite a friend",
                  child: Text("Invite a friend"),
                ),
                const PopupMenuItem(
                  value: "Contacts",
                  child: Text("Contacts"),
                ),
                const PopupMenuItem(
                  value: "Refresh",
                  child: Text("Refresh"),
                ),
                const PopupMenuItem(
                  value: "Help",
                  child: Text("Help"),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => const CreateGroup()),
                );
              },
              child: const ButtonCard(
                icon: Icons.group,
                name: "New group",
              ),
            );
          } else if (index == 1) {
            return const ButtonCard(
              icon: Icons.person_add,
              name: "New contact",
            );
          }
          return ContactCard(
            contact: contacts[index - 2],
          );
        },
      ),
    );
  }
}
