import 'package:datingapp/components/chat_page_components/chatbubble.dart';
import 'package:datingapp/pages/personaility_pages/personailty_prediction_result_page.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
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

  Future<void> connectToGPT() async {
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

    messagesSent.add(ChatBubble(messageText: message, isCurrentUser: false));
  }

  Future<void> continueChat() async {
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

    setState(() {
      messagesSent.add(ChatBubble(messageText: message, isCurrentUser: false));
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

  int indexController = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messagesSent.length,
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.only(top: 100, bottom: 5),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 16, top: 10, bottom: 10),
                  child: Align(
                      alignment: (messagesSent[index].isCurrentUser == false
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messagesSent[index].isCurrentUser == false
                              ? Colors.grey.shade200
                              : Colors.deepPurpleAccent[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(messagesSent[index].messageText),
                      ))
                  // add a delay for the next questions

                  );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 30, bottom: 10, top: 10, right: 30),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    // Textfeild for users to write a message
                    child: TextField(
                      controller: myController,
                      decoration: const InputDecoration(
                          hintText: " Respond to the question....",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        // when user presses the send message show it in the ui
                        // retrieve the text that the user has entered by using the textediting controller
                        //content: Text(myController.text),
                        // add the user's response to the string that will be sent to the next screen
                        allResponses = "$allResponses  ${myController.text}";

                        messagesSent.add(ChatBubble(
                            messageText: myController.text,
                            isCurrentUser: true));

                        // messagesSent.add(messages[indexController]);

                        indexController += 1;

                        continueChat();

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
                    backgroundColor: Colors.white,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.blue,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
