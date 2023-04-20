class PersonalityClassifer {
  late Map<String, double> personalityMap;
  late int statusCode;
  late String extraversionIntroversion;
  late String sensingIntuition;
  late String thinkingFeeling;
  late String judgingPerceiving;

  PersonalityClassifer(Map<String, double> map) {
    personalityMap = map;
  }

  String classifyPersonality() {
    String personality = "";

    for (var key in personalityMap.keys) {
      switch (key) {
        case "extraversion":
          if (personalityMap[key]! > 0.5) {
            extraversionIntroversion = "E";
          } else {
            extraversionIntroversion = "I";
          }
          break;
        case "imaginative":
          if (personalityMap[key]! > 0.5) {
            sensingIntuition = "N";
          } else {
            sensingIntuition = "S";
          }
          break;
        case "emotionally_aware":
          if (personalityMap[key]! > 0.5) {
            thinkingFeeling = "F";
          } else {
            thinkingFeeling = "T";
          }
          break;
        case "disciplined":
          if (personalityMap[key]! > 0.5) {
            judgingPerceiving = "P";
          } else {
            judgingPerceiving = "J";
          }
          break;
      }
    }

    personality = extraversionIntroversion +
        sensingIntuition +
        thinkingFeeling +
        judgingPerceiving;
    return personality;
  }
}
