import 'package:chatapp/CustomUI/ButtonCard.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/Homescreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel? sourceChat;
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      currentMessage: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),
    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),
    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              sourceChat = chatmodels[index]; // Assign before removing
              chatmodels.removeAt(index);
            });

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (builder) => Homescreen(
                  chatmodels: chatmodels,
                  sourceChat: sourceChat!,
                ),
              ),
            );
          },
          child: ButtonCard(
            name: chatmodels[index].name,
            icon: Icons.person,
          ),
        ),
      ),
    );
  }
}
