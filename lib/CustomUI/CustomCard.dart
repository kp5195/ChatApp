import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chatapp/Model/ChatModel.dart';
import 'package:chatapp/Screens/IndividualPage.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.chatModel,
    required this.sourchat,
  }) : super(key: key);

  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
              sourchat: sourchat,
            ),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: SvgPicture.asset(
                chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                height: 36,
                width: 36,
                color: Colors.white,
              ),
            ),
            title: Text(
              chatModel.name ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.done_all,
                  size: 16,
                  color: Colors.blue,
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    chatModel.currentMessage ?? '',
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            trailing: Text(
              chatModel.time ?? '',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(thickness: 1),
          ),
        ],
      ),
    );
  }
}
