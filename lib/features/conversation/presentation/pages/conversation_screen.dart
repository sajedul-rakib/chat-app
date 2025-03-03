import 'package:chat_app/features/signup/data/models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../signup/presentation/widget/text_form_field.dart';
import '../widgets/message_box.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key, required this.myuser});

  final MyUser myuser;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late bool messageType;

  @override
  void initState() {
    messageType = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                //overview the friend profile
                _showProfilePic(widget.myuser.profilePic!,
                    widget.myuser.fullname, widget.myuser.email);
              },
              child: CircleAvatar(
                // radius: 20,
                backgroundImage: NetworkImage(widget.myuser.profilePic!),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.myuser.fullname,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
        actions: const [
          Icon(FontAwesomeIcons.magnifyingGlass),
          SizedBox(
            width: 20,
          ),
          Icon(FontAwesomeIcons.bars),
          SizedBox(
            width: 20,
          )
        ],
      ),
      backgroundColor:
          isDark ? const Color(0xff152033) : const Color(0xffFFFFFF),
      // bottomNavigationBar: const BottomAppBar(
      //   child: InputFormField(
      //     hintText: "Message",
      //     suffix: Icon(CupertinoIcons.add_circled_solid),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // MessageBox(
                    //   bubbleType: BubbleType.receiverBubble,
                    //   message: 'I am fine, what about you?',
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // MessageBox(
                    //   bubbleType: BubbleType.sendBubble,
                    //   message: 'Whar are you doin now?',
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    MessageBox(
                        bubbleType: BubbleType.receiverBubble,
                        message: 'I love you'),
                    MessageBox(
                        bubbleType: BubbleType.sendBubble,
                        message: 'I love you too'),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // MessageBox(
                    //     bubbleType: BubbleType.sendBubble,
                    //     message: 'Do something for me..'),
                    // SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: InputFormField(
                hintText: "Message",
                onChange: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      messageType = true;
                    });
                  } else {
                    setState(() {
                      messageType = false;
                    });
                  }
                },
                prefix: Icon(CupertinoIcons.mail),
                suffix: messageType == true
                    ? Icon(CupertinoIcons.paperplane_fill)
                    : SizedBox(
                        width: 100,
                        child: Row(
                          spacing: 10,
                          children: [
                            Icon(CupertinoIcons.add_circled_solid),
                            Icon(CupertinoIcons.mic_fill),
                            Icon(CupertinoIcons.qrcode_viewfinder)
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //show the profile pic of the friend and his/her name and email
  void _showProfilePic(String profilePicUrl, String fullName, String mail) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(profilePicUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                fullName,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                mail,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}
