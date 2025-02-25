import 'package:chatapp/CustomUI/AvatarCard.dart';
import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/CustomUI/ContactCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Dev Stack", status: "A full stack developer", select: false),
    ChatModel(name: "Balram", status: "Flutter Developer...........", select: false),
    ChatModel(name: "Saket", status: "Web developer...", select: false),
    ChatModel(name: "Bhanu Dev", status: "App developer....", select: false),
    ChatModel(name: "Collins", status: "React developer..", select: false),
    ChatModel(name: "Kishor", status: "Full Stack Web", select: false),
    ChatModel(name: "Testing1", status: "Example work", select: false),
    ChatModel(name: "Testing2", status: "Sharing is caring", select: false),
    ChatModel(name: "Divyanshu", status: ".....", select: false),
    ChatModel(name: "Helper", status: "Love you Mom Dad", select: false),
    ChatModel(name: "Tester", status: "I find the bugs", select: false),
  ];

  List<ChatModel> groupMembers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add participants",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 26),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF128C7E),
        onPressed: () {},
        child: const Icon(Icons.arrow_forward),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(
                  height: groupMembers.isNotEmpty ? 90 : 10,
                );
              }
              return InkWell(
                onTap: () {
                  setState(() {
                    ChatModel selectedContact = contacts[index - 1];
                    if (selectedContact.select) {
                      groupMembers.remove(selectedContact);
                      selectedContact.select = false;
                    } else {
                      groupMembers.add(selectedContact);
                      selectedContact.select = true;
                    }
                  });
                },
                child: ContactCard(contact: contacts[index - 1]),
              );
            },
          ),
          if (groupMembers.isNotEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    height: 75,
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: groupMembers.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              groupMembers[index].select = false;
                              groupMembers.removeAt(index);
                            });
                          },
                          child: AvatarCard(chatModel: groupMembers[index]),
                        );
                      },
                    ),
                  ),
                  const Divider(thickness: 1),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
