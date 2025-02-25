import 'package:chatapp/Model/ChatModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, required this.contact}) : super(key: key);

  final ChatModel contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 53,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey[200],
              child: SvgPicture.asset(
                "assets/person.svg",
                height: 30,
                width: 30,
                fit: BoxFit.cover, // Ensures proper SVG scaling
              ),
            ),
            if (contact.select ?? false) // Safe null check
              Positioned(
                bottom: 4,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 11,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
      title: Text(
        contact.name ?? '', // Prevents null errors
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        contact.status ?? '', // Prevents null errors
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
