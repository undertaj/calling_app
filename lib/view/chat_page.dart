import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatsBody extends StatefulWidget {
  const ChatsBody({super.key});

  @override
  State<ChatsBody> createState() => _ChatsBodyState();
}

class _ChatsBodyState extends State<ChatsBody> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {'message': 'Hello', 'isMe': false, 'isAudio': false},
    {'message': 'Hi', 'isMe': true, 'isAudio': false},
    {'message': 'How are you?', 'isMe': false, 'isAudio': false},
    {'message': 'I am fine', 'isMe': true, 'isAudio': false},
    {'message': 'What about you?', 'isMe': true, 'isAudio': false},
    {'message': 'I am also fine', 'isMe': false, 'isAudio': false},
    {'message': 'Good to hear that', 'isMe': true, 'isAudio': false},
    {
      'message': 'Can I help you with anything?',
      'isMe': false,
      'isAudio': false
    },
    {'message': 'No, thanks', 'isMe': true, 'isAudio': false},
    {'message': 'Okay', 'isMe': false, 'isAudio': false},
    {'message': 'Bye', 'isMe': true, 'isAudio': false},
    {'message': 'Bye', 'isMe': false, 'isAudio': false},
    {'message': 'Lorem ipsum dolor sit amet', 'isMe': false, 'isAudio': false},
    {'message': 'Consectetur adipiscing elit', 'isMe': true, 'isAudio': false},
    {
      'message':
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
      'isMe': false,
      'isAudio': false,
    },
    {'message': 'Ut enim ad minim veniam', 'isMe': true, 'isAudio': false},
    {
      'message': '02:45',
      'isMe': false,
      'isAudio': true,
    },
    {
      'message':
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
      'isMe': true,
      'isAudio': false,
    },
    {
      'message': 'Excepteur sint occaecat cupidatat non proident',
      'isMe': false,
      'isAudio': false
    },
    {
      'message':
      'Sunt in culpa qui officia deserunt mollit anim id est laborum',
      'isMe': true,
      'isAudio': false
    },
  ];

  void _addMessage(String message, bool isMe) {
    setState(() {
      _messages.add({'message': message, 'isMe': isMe});
    });
    _controller.clear();
  }

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _controller.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              index = _messages.length - 1 - index;
              final message = _messages[index]['message'];
              final isMe = _messages[index]['isMe'];
              final isAudio = _messages[index]['isAudio'];

              return ListTile(
                title: Align(
                  alignment:
                  isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color(0xff5755D9)
                          : const Color(0xff484554).withOpacity(0.08),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isMe ? 16.0 : 0.0),
                        topRight: Radius.circular(isMe ? 0.0 : 16.0),
                        bottomLeft: const Radius.circular(16.0),
                        bottomRight: const Radius.circular(16.0),
                      ),
                    ),
                    child: isAudio
                        ? Column(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff9B98A4),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Color(0xffF4F4F6),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Image.asset(
                                'assets/images/audio_wave.png',
                                width: 140,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          message,
                          textAlign:
                          isMe ? TextAlign.right : TextAlign.left,
                          style: TextStyle(
                            color: isMe
                                ? const Color(0xffF4F4F6)
                                : const Color(0xff9B98A4),
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            fontFamily:
                            GoogleFonts.montserrat().fontFamily,
                          ),
                        ),
                      ],
                    )
                        : Text(
                      message,
                      style: TextStyle(
                        color: isMe
                            ? const Color(0xffF4F4F6)
                            : const Color(0xff484554),
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(
          height: 1,
          color: Color(0xff9B98A4),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/camera.svg',
                width: 24,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 16,
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                height: 38,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type Message...',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 8.0,
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff9B98A4),
                      fontWeight: FontWeight.w400,
                      fontSize: 13.0,
                      fontFamily: 'Inter',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: const Color(0xff9B98A4).withOpacity(0.3),
                        width: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
              _controller.text.isEmpty
                  ? Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff5755D9),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _addMessage('02:45', true);
                  },
                ),
              )
                  : IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Color(0xff5755D9),
                ),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _addMessage(
                      _controller.text,
                      true,
                    ); // Sent by the current user
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}