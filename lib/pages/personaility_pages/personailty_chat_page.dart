import 'dart:ui';

import 'package:datingapp/components/chat_page_components/chat_bubble.dart';
import 'package:datingapp/components/chat_page_components/typing_indicator/typing_indicator.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
// ignore: implementation_imports
import 'package:openai_client/src/model/openai_chat/chat_message.dart';

class PersonailtyChatPage extends StatefulWidget {
  const PersonailtyChatPage({super.key});

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

  void turnBubbleOn() {
    bubble = const TypingIndicator(
      showIndicator: true,
    );
  }

  void turnBubbleOff() {
    bubble = const TypingIndicator(
      showIndicator: false,
    );
  }

  void addMessageForGPT() {
    setState(() {
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
    connectToGPT();
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
                            setState(() {
                              // when user presses the send message show it in the ui
                              // retrieve the text that the user has entered by using the textediting controller
                              //content: Text(myController.text),
                              // add the user's response to the string that will be sent to the next screen
                              allResponses =
                                  "$allResponses  ${myController.text}";

                              messagesSent.add(ChatBubble(
                                  messageText: myController.text,
                                  isCurrentUser: true,
                                  bubble: const TypingIndicator(
                                      showIndicator: false)));

                              // messagesSent.add(messages[indexController]);

                              indexController += 1;

                              continueChat();
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                              myController.clear();

                              //print(myController.text);
                              //print(messages.last.messageText);

                              // if we the indexed is at the last mesage in the questionaire then we go to the next page
                              // if (indexController == messages.length) {
                              //   print("Completed questionaire");
                              //   print(allResponses);
                              //   // go to the next page to predict the personailty results
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             PersonailtyPredictionResultPage(
                              //               userQuestionareResults: allResponses,
                              //             )),
                              //   );
                              // }
                            });
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          child: Icon(
                            Icons.send,
                            color: AppStyle.red500,
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
