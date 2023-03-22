import 'package:datingapp/components/chatbubble.dart';
import 'package:datingapp/pages/personaility_pages/personailty_prediction_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';

class PersonailtyChatPage extends StatefulWidget {
  const PersonailtyChatPage({super.key});

  @override
  State<PersonailtyChatPage> createState() => _PersonailtyChatPage();
}

class _PersonailtyChatPage extends State<PersonailtyChatPage> {
  final myController = TextEditingController();

  List<ChatBubble> messages = [
    ChatBubble(
        messageText: "What was the best part of your day?",
        isCurrentUser: false),
    ChatBubble(
        messageText: "What were you for Halloween last year?",
        isCurrentUser: false),
    ChatBubble(messageText: "Do you like to read ?", isCurrentUser: false),
    ChatBubble(messageText: "How often do you go out ?", isCurrentUser: false),
    ChatBubble(
        messageText: "Go to sing-a-long song for the car",
        isCurrentUser: false),
    ChatBubble(messageText: "Are you into routines?", isCurrentUser: false),
    ChatBubble(messageText: "Favorite weekend activity?", isCurrentUser: false),
    ChatBubble(
        messageText: "Who's the closest person to you?", isCurrentUser: false),
    ChatBubble(
        messageText:
            "If your house was burning, what would one item you would take to save?",
        isCurrentUser: false),
    ChatBubble(messageText: "How do you handle stress?", isCurrentUser: false),
    ChatBubble(
        messageText: "Greatest failure you’ve come across from?",
        isCurrentUser: false),
    ChatBubble(
        messageText:
            "If you’re in a bad mood, would you like to be alone or have company with you?",
        isCurrentUser: false),
    ChatBubble(messageText: "Are you a photo taker?", isCurrentUser: false),
    ChatBubble(
        messageText: "Reminisce on memories or look forward to the future?",
        isCurrentUser: false),
    ChatBubble(
        messageText: "What is your favorite part of the day?",
        isCurrentUser: false),
    ChatBubble(
        messageText: "Morning person or night owl?", isCurrentUser: false),
    ChatBubble(
        messageText: "How do you show care for others?", isCurrentUser: false),
    ChatBubble(messageText: "Who is your hero?", isCurrentUser: false),
    ChatBubble(
        messageText:
            "What is one gift you have received that you value the most?",
        isCurrentUser: false),
    ChatBubble(
        messageText: "What is one aspect you and your friends have in common?",
        isCurrentUser: false),
    ChatBubble(
        messageText: "What is your guilty pleasure?", isCurrentUser: false),
    ChatBubble(
        messageText: "What is your unique factor/sets you a part from others?",
        isCurrentUser: false),
    ChatBubble(
        messageText: "What subject did you do best in school or like?",
        isCurrentUser: false),
    ChatBubble(messageText: "Favorite hobby?", isCurrentUser: false),
    ChatBubble(messageText: "Going out or staying in?", isCurrentUser: false),
    ChatBubble(
        messageText: "Best advice someone has given you?",
        isCurrentUser: false),
    ChatBubble(
        messageText: "What are some pet peeves you have?",
        isCurrentUser: false),
    ChatBubble(messageText: "Do you like to cook?", isCurrentUser: false),
    ChatBubble(
        messageText: "Are you a talker or listenter?", isCurrentUser: false),
    ChatBubble(
        messageText: "What was your favoriter toy growing up?",
        isCurrentUser: false),
    ChatBubble(
        messageText: "Congrations you have completed the questionaire",
        isCurrentUser: false)
  ];

  List<ChatBubble> messagesSent = [
    ChatBubble(
        messageText: "Hello Welcome to our Personailty Prediction Chat Bot",
        isCurrentUser: false),
  ];

  // String to hold all the responses to send to the personailty prediction results
  String allResponses = " ";

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
            padding: EdgeInsets.only(top: 100, bottom: 5),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 16, top: 10, bottom: 10),
                  child: Align(
                      alignment: (messagesSent[index].isCurrentUser == false
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messagesSent[index].isCurrentUser == false
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
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
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  Expanded(
                    // Textfeild for users to write a message
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          hintText: " Respond to the question....",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        // when user presses the send message show it in the ui
                        // retrieve the text that the user has entered by using the textediting controller
                        //content: Text(myController.text),
                        // add the user's response to the string that will be sent to the next screen
                        allResponses = allResponses + myController.text;

                        messagesSent.add(ChatBubble(
                            messageText: myController.text,
                            isCurrentUser: true));

                        messagesSent.add(messages[indexController]);

                        indexController += 1;

                        //print(myController.text);
                        //print(messages.last.messageText);

                        // if we the indexed is at the last mesage in the questionaire then we go to the next page
                        if (indexController == messages.length) {
                          print("Completed questionaire");
                          print(allResponses);
                          // go to the next page to predict the personailty results
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PersonailtyPredictionResultPage(
                                      userQuestionareResults: allResponses,
                                    )),
                          );
                        }
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
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
