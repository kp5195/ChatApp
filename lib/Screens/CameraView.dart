import 'dart:io';
import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.crop_rotate, size: 27),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined, size: 27),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.title, size: 27),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 27),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            color: Colors.black38,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              maxLines: 6,
              minLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Add Caption...",
                hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                prefixIcon: const Icon(
                  Icons.add_photo_alternate,
                  color: Colors.white,
                  size: 27,
                ),
                suffixIcon: CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.tealAccent[700],
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
