import 'package:chatapp_new/CustomUI/OwnMessgaeCrad.dart';
import 'package:chatapp_new/CustomUI/ReplyCard.dart';
import 'package:chatapp_new/Model/ChatModel.dart';
import 'package:chatapp_new/Model/MessageModel.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, required this.chatModel, required this.sourchat}) : super(key: key);

  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.0.106:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourchat.id);

    socket.onConnect((_) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString().substring(10, 16),
    );

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatModel.name, style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold)),
                Text("last seen today at 12:05", style: TextStyle(fontSize: 13)),
              ],
            ),
            actions: [
              IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
              IconButton(icon: Icon(Icons.call), onPressed: () {}),
              PopupMenuButton<String>(
                onSelected: (value) => print(value),
                itemBuilder: (context) => [
                  PopupMenuItem(value: "View Contact", child: Text("View Contact")),
                  PopupMenuItem(value: "Media, links, and docs", child: Text("Media, links, and docs")),
                  PopupMenuItem(value: "Search", child: Text("Search")),
                  PopupMenuItem(value: "Mute Notification", child: Text("Mute Notification")),
                  PopupMenuItem(value: "Wallpaper", child: Text("Wallpaper")),
                ],
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              if (show) {
                setState(() {
                  show = false;
                });
                return false;
              }
              return true;
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return messages[index].type == "source"
                          ? OwnMessageCard(message: messages[index].message, time: messages[index].time)
                          : ReplyCard(message: messages[index].message, time: messages[index].time);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: focusNode,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (value) {
                            setState(() {
                              sendButton = value.isNotEmpty;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Type a message",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                            prefixIcon: IconButton(
                              icon: Icon(show ? Icons.keyboard : Icons.emoji_emotions_outlined),
                              onPressed: () {
                                focusNode.unfocus();
                                focusNode.canRequestFocus = false;
                                setState(() {
                                  show = !show;
                                });
                              },
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
                                IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xFF128C7E),
                        child: IconButton(
                          icon: Icon(sendButton ? Icons.send : Icons.mic, color: Colors.white),
                          onPressed: () {
                            if (sendButton) {
                              sendMessage(_controller.text, widget.sourchat.id, widget.chatModel.id);
                              _controller.clear();
                              setState(() {
                                sendButton = false;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (show) emojiSelect(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        setState(() {
          _controller.text += emoji.emoji;
        });
      },
    );
  }
}
