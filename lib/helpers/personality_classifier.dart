class PersonalityClassifer {
  late Map<String, double> personalityMap;
  late int extroverted;
  late int introverted;
  late int sensing;
  late int intuition;
  late int thinking;
  late int feeling;
  late int judging;
  late int perceiving;
  late String extraversionIntroversion;
  late String sensingIntuition;
  late String thinkingFeeling;
  late String judgingPerceiving;
  late String personalityType;

  PersonalityClassifer(Map<String, double> map) {
    personalityMap = map;
    extroverted = 0;
    introverted = 0;
    sensing = 0;
    intuition = 0;
    thinking = 0;
    feeling = 0;
    judging = 0;
    perceiving = 0;
    extraversionIntroversion = "";
    sensingIntuition = "";
    thinkingFeeling = "";
    judgingPerceiving = "";
    personalityType = "";
  }

  String classifyPersonality() {
    for (var key in personalityMap.keys) {
      switch (key) {
        case "extraversion":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
        case "active":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "assertive":
          if (personalityMap[key]! > 0.5) {
            feeling += 1;
          } else {
            thinking += 1;
          }
          break;
        case "cheerful":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
        case "openness":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
        case "adventurous":
          if (personalityMap[key]! > 0.5) {
            judging += 1;
          } else {
            perceiving += 1;
          }
          break;
        case "artistic":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "emotionally_aware":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "imaginative":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "intellectual":
          if (personalityMap[key]! > 0.5) {
            thinking += 1;
          } else {
            feeling += 1;
          }
          break;
        case "conscientiousness":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "cautious":
          if (personalityMap[key]! > 0.5) {
            judging += 1;
          } else {
            perceiving += 1;
          }
          break;
        case "disciplined":
          if (personalityMap[key]! > 0.5) {
            judging += 1;
          } else {
            perceiving += 1;
          }
          break;
        case "dutiful":
          if (personalityMap[key]! > 0.5) {
            thinking += 1;
          } else {
            feeling += 1;
          }
          break;
        case "neuroticism":
          if (personalityMap[key]! > 0.5) {
            thinking += 1;
          } else {
            feeling += 1;
          }
          break;
        case "melancholy":
          if (personalityMap[key]! > 0.5) {
            judging += 1;
          } else {
            perceiving += 1;
          }
          break;
        case "self_conscious":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "authority_challenging":
          if (personalityMap[key]! > 0.5) {
            judging += 1;
          } else {
            perceiving += 1;
          }
          break;
        case "achievement_striving":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "orderliness":
          if (personalityMap[key]! > 0.5) {
            judging += 1;
          } else {
            perceiving += 1;
          }
          break;
        case "self_efficacy":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
        case "stress_prone":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
        case "agreeableness":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "cooperative":
          if (personalityMap[key]! > 0.5) {
            thinking += 1;
          } else {
            feeling += 1;
          }
          break;
        case "trusting":
          if (personalityMap[key]! > 0.5) {
            thinking += 1;
          } else {
            feeling += 1;
          }
          break;
        case "excitement_seeking":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
        case "outgoing":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
        case "gregariousness":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
        case "altruism":
          if (personalityMap[key]! > 0.5) {
            thinking += 1;
          } else {
            feeling += 1;
          }
          break;
        case "modesty":
          if (personalityMap[key]! > 0.5) {
            judging += 1;
          } else {
            perceiving += 1;
          }
          break;
        case "uncompromising":
          if (personalityMap[key]! > 0.5) {
            judging += 1;
          } else {
            perceiving += 1;
          }
          break;
        case "sympathy":
          if (personalityMap[key]! > 0.5) {
            intuition += 1;
          } else {
            sensing += 1;
          }
          break;
        case "fiery":
          if (personalityMap[key]! > 0.5) {
            thinking += 1;
          } else {
            feeling += 1;
          }
          break;
        case "prone_to_worry":
          if (personalityMap[key]! > 0.5) {
            thinking += 1;
          } else {
            feeling += 1;
          }
          break;
        case "immoderation":
          if (personalityMap[key]! > 0.5) {
            extroverted += 1;
          } else {
            introverted += 1;
          }
          break;
      }
    }

    calculatePersonality();
    return getPersonalityType;
  }

  void calculatePersonality() {
    if (extroverted > introverted) {
      extraversionIntroversion += "E";
    } else {
      extraversionIntroversion += "I";
    }

    if (sensing > intuition) {
      sensingIntuition += "S";
    } else {
      sensingIntuition += "N";
    }

    if (thinking > feeling) {
      thinkingFeeling += "T";
    } else {
      thinkingFeeling += "F";
    }

    if (judging > perceiving) {
      judgingPerceiving += "J";
    } else {
      judgingPerceiving += "P";
    }

    personalityType = extraversionIntroversion +
        sensingIntuition +
        thinkingFeeling +
        judgingPerceiving;
  }

  get getPersonalityType {
    return personalityType;
  }
}
