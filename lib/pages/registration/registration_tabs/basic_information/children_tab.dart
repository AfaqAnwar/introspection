import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ChildrenTab extends StatefulWidget {
  final CurrentUser currentUser;
  final Function() updateIndex;
  const ChildrenTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<ChildrenTab> createState() => ChildrenTabState();
}

class ChildrenTabState extends State<ChildrenTab> {
  final hasChildrenController = GroupButtonController();
  final childrenPreferencesController = GroupButtonController();

  bool? hasChildren;
  String childrenPreference = "";

  String errorMessage = "";

  @override
  void initState() {
    if (widget.currentUser.getHasChildren != null) {
      hasChildren = widget.currentUser.getHasChildren;
      if (widget.currentUser.getHasChildren == true) {
        hasChildrenController.selectIndex(1);
      } else {
        hasChildrenController.selectIndex(0);
      }
    }

    if (widget.currentUser.getChildrenPreference.isNotEmpty) {
      childrenPreference = widget.currentUser.getChildrenPreference;
      if (widget.currentUser.getChildrenPreference == "Don't want children") {
        childrenPreferencesController.selectIndex(0);
      } else if (widget.currentUser.getChildrenPreference == "Want children") {
        childrenPreferencesController.selectIndex(1);
      } else if (widget.currentUser.getChildrenPreference ==
          "Open to hildren") {
        childrenPreferencesController.selectIndex(2);
      }
    }
    super.initState();
  }

  String getErrorMessage() {
    if (childrenPreference.isEmpty && hasChildren == null) {
      errorMessage =
          "Please let us know if you would like to have children and specify if you have children.";
    } else if (childrenPreference.isEmpty) {
      errorMessage = "Please let us know if you would like to have children.";
    } else if (hasChildren == null) {
      errorMessage = "Please specify if you have children.";
    }
    return errorMessage;
  }

  bool validateChildrenQuestions() {
    if (hasChildren != null && childrenPreference.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void updateChildrenQuestions() {
    widget.currentUser.setHasChildren = hasChildren;
    widget.currentUser.setChildrenPreference = childrenPreference;
  }

  @override
  String toStringShort() {
    return getErrorMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "What about children?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Marlide-Display',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                    controller: hasChildrenController,
                    options: GroupButtonOptions(
                      mainGroupAlignment: MainGroupAlignment.start,
                      crossGroupAlignment: CrossGroupAlignment.start,
                      groupRunAlignment: GroupRunAlignment.start,
                      unselectedColor: Colors.grey,
                      selectedColor: AppStyle.red800,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    maxSelected: 1,
                    enableDeselect: false,
                    isRadio: true,
                    onSelected: (value, index, isSelected) {
                      if (isSelected) {
                        if (index == 0) {
                          hasChildren = false;
                        } else {
                          hasChildren = true;
                        }
                      }
                    },
                    buttons: const [
                      "Don't have children",
                      "Have children",
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            )),
        const SizedBox(
          height: 25,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GroupButton(
                    controller: childrenPreferencesController,
                    options: GroupButtonOptions(
                      mainGroupAlignment: MainGroupAlignment.start,
                      crossGroupAlignment: CrossGroupAlignment.start,
                      groupRunAlignment: GroupRunAlignment.start,
                      unselectedColor: Colors.grey,
                      selectedColor: AppStyle.red800,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    maxSelected: 1,
                    enableDeselect: false,
                    isRadio: true,
                    onSelected: (value, index, isSelected) {
                      if (isSelected) {
                        if (index == 0) {
                          childrenPreference = "Don't want children";
                        } else if (index == 1) {
                          childrenPreference = "Want children";
                        } else {
                          childrenPreference = "Open to children";
                        }
                      }
                    },
                    buttons: const [
                      "Don't want children",
                      "Want children",
                      "Open to children",
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
