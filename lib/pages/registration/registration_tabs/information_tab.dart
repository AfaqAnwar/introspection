abstract class InformationTab {
  static void initializeWith(InformationTab instance) {
    _instance = instance;
  }

  static late InformationTab _instance;
  static InformationTab get instance => _instance;

  void updateUserInformation();
  bool validate();
  String getErrorMessage();

  static void staticUpdateUserInformation() =>
      _instance.updateUserInformation();
  static bool staticValidate() => _instance.validate();
  static String staticGetErrorMessage() => _instance.getErrorMessage();
}
