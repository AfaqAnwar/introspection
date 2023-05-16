import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:introspection/components/chat_page_components/chat_bubble.dart';
import 'package:introspection/components/chat_page_components/typing_indicator/typing_indicator.dart';
import 'package:introspection/data/custom_user.dart';
import 'package:introspection/pages/personaility_chat/personailty_prediction_result_page.dart';
import 'package:introspection/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart' hide Color;
// ignore: implementation_imports
import 'package:openai_client/src/model/openai_chat/chat_message.dart';

class PersonailtyChatPage extends StatefulWidget {
  final CustomUser currentUser;
  const PersonailtyChatPage({super.key, required this.currentUser});

  @override
  State<PersonailtyChatPage> createState() => _PersonailtyChatPage();
}

class _PersonailtyChatPage extends State<PersonailtyChatPage> {
  final myController = TextEditingController();
  List<ChatBubble> messagesSent = [];
  String allResponses = "";
  int indexController = 0;
  final ScrollController _scrollController = ScrollController();
  Widget bubble = const TypingIndicator(
    showIndicator: false,
  );
  late bool buttonDisabled;
  Color buttonColor = AppStyle.red900;

  void addMessageForGPT() {
    setState(() {
      disableButton();
      messagesSent.add(ChatBubble(
          messageText: "",
          isCurrentUser: false,
          bubble: const TypingIndicator(
            showIndicator: true,
          )));
    });
  }

  Future<void> connectToGPT() async {
    addMessageForGPT();
    // Load app credentials from environment variables or file.
    const configuration = OpenAIConfiguration(
        apiKey: "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");

    // Create a new client.
    final client = OpenAIClient(
      configuration: configuration,
      enableLogging: true,
    );

    // Create a chat.
    final chat = await client.chat.create(
      model: 'gpt-3.5-turbo',
      messages: const [
        ChatMessage(
          role: 'system',
          content:
              'You are a chatbot that is trying to find out about a user\'s personality. Ask the user questions to learn about their personality. You can ask the user about their hobbies, interests, and more.',
        )
      ],
    ).data;

    var chatMap = chat.toMap();
    var message = chatMap['choices'][0]['message']['content'];
    messagesSent[messagesSent.length - 1].setMessageText = message;
    setState(() {
      messagesSent[messagesSent.length - 1].turnOffBubble();
    });
    enableButton();
  }

  Future<void> continueChat() async {
    addMessageForGPT();

    const configuration = OpenAIConfiguration(
        apiKey: "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");

    // Create a new client.
    final client = OpenAIClient(
      configuration: configuration,
      enableLogging: true,
    );

    final chat = await client.chat
        .create(
          model: 'gpt-3.5-turbo',
          messages: createListOfChatMessages(),
        )
        .data;

    var chatMap = chat.toMap();
    var message = chatMap['choices'][0]['message']['content'];

    messagesSent[messagesSent.length - 1].setMessageText = message;
    setState(() {
      messagesSent[messagesSent.length - 1].turnOffBubble();
    });
    enableButton();
  }

  List<ChatMessage> createListOfChatMessages() {
    List<ChatMessage> chatMessages = [];
    chatMessages.add(const ChatMessage(
      role: 'system',
      content:
          'You are a chatbot that is trying to find out about a user\'s personality. Ask the user questions to learn about their personality. You can ask the user about their hobbies, interests, and more.',
    ));
    for (int i = 0; i < messagesSent.length; i++) {
      if (messagesSent[i].isCurrentUser == true) {
        chatMessages.add(ChatMessage(
          role: 'user',
          content: messagesSent[i].getMessageText,
        ));
      } else {
        chatMessages.add(ChatMessage(
          role: 'system',
          content: messagesSent[i].getMessageText,
        ));
      }
    }
    return chatMessages;
  }

  @override
  void initState() {
    super.initState();
    disableButton();
    Future.delayed(Duration.zero, () {
      showPopUp();
    });
  }

  void disableButton() {
    setState(() {
      buttonDisabled = true;
      buttonColor = Colors.grey.shade500;
    });
  }

  void enableButton() {
    setState(() {
      buttonDisabled = false;
      buttonColor = AppStyle.red600;
    });
  }

  void showPopUp() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  1)!,
              backgroundColor: Colors.grey.shade200.withOpacity(0.5),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      "Before We Begin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppStyle.red800),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "You'll need to chat with out chatbot for a few minutes to get to know you. This will help us find you the best matches. We'll ask you a few questions about your personality and interests. Please answer as honestly as possible.",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    connectToGPT();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                        child: Text(
                      "Let's Go",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  void showEndPopUp() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  1)!,
              backgroundColor: Colors.grey.shade200.withOpacity(0.5),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      "Thank You",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppStyle.red800),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "We'll take a moment to figure out your personality and interests. We'll be back with your matches shortly.",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PersonailtyPredictionResultPage(
                                    currentUser: widget.currentUser,
                                    userQuestionareResults: allResponses,
                                  )));
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                        child: Text(
                      "Let's Finish!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  void endChat() {
    addMessageForGPT();
    messagesSent[messagesSent.length - 1].setMessageText =
        "Thanks for chatting!, I hope you find your perfect match!";
    setState(() {
      messagesSent[messagesSent.length - 1].turnOffBubble();
    });
    showEndPopUp();
  }

  void showEmptyTextPopUp() {
    Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageText: const Text("Please enter a message",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          )),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 1),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: double.infinity,
              height: 100.0,
              decoration:
                  BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 40, bottom: 10, top: 10, right: 10),
                  height: 80,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        // Textfeild for users to write a message
                        child: TextField(
                          controller: myController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: AppStyle.red600)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      BorderSide(color: AppStyle.red900)),
                              hintText: " Type your answer here...",
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: FloatingActionButton(
                          onPressed: () {
                            if (buttonDisabled == false) {
                              if (myController.text.trim().isEmpty) {
                                showEmptyTextPopUp();
                              } else {
                                setState(() {
                                  allResponses =
                                      "$allResponses  ${myController.text}";

                                  messagesSent.add(ChatBubble(
                                      messageText: myController.text,
                                      isCurrentUser: true,
                                      bubble: const TypingIndicator(
                                          showIndicator: false)));

                                  indexController += 1;

                                  // Message Threshold Needs To Be Modified!
                                  // Check User Message Words?
                                  if (messagesSent.length >= 7) {
                                    endChat();
                                  } else {
                                    continueChat();
                                    _scrollController.animateTo(
                                        _scrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                    myController.clear();
                                  }
                                });
                              }
                            } else {}
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          child: Icon(
                            Icons.send,
                            color: buttonColor,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Stack(
            children: <Widget>[
              ListView.builder(
                controller: _scrollController,
                itemCount: messagesSent.length,
                shrinkWrap: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.only(top: 40, bottom: 5),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messagesSent[index].isCurrentUser == false
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: (messagesSent[index].getBubble.showIndicator ==
                                false
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (messagesSent[index].isCurrentUser ==
                                          false
                                      ? Colors.grey.shade200
                                      : AppStyle.red700),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  messagesSent[index].messageText,
                                  style: TextStyle(
                                      color:
                                          (messagesSent[index].isCurrentUser ==
                                                  false
                                              ? Colors.black
                                              : Colors.white)),
                                ),
                              )
                            : const TypingIndicator(
                                showIndicator: true,
                              )),
                      )
                      // add a delay for the next questions

                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
