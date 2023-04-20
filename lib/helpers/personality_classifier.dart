class PersonalityClassifer {
  late Map<String, double> personalityMap;
  late int statusCode;

  PersonalityClassifer(Map<String, double> map) {
    personalityMap = map;
  }

  String classifyPersonality() {
    String personality = "";

    for (var key in personalityMap.keys) {
      switch (key) {
        case "extraversion":
          if (personalityMap[key]! > 0.5) {
            personality += "E";
          } else {
            personality += "I";
          }
          break;
        case "imaginative":
          if (personalityMap[key]! > 0.5) {
            personality += "N";
          } else {
            personality += "S";
          }
          break;
        case "emotionally_aware":
          if (personalityMap[key]! > 0.5) {
            personality += "F";
          } else {
            personality += "T";
          }
          break;
        case "disciplined":
          if (personalityMap[key]! > 0.5) {
            personality += "J";
          } else {
            personality += "P";
          }
          break;
      }
    }

    return personality;
  }
}
