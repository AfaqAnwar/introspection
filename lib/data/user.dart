class User {
  late String firstName;
  late String lastName;
  late String email;
  late String dob;
  late String zipcode;
  late String city;
  late String state;
  late String country;
  late String gender;
  late String genderPreference;
  late String height;
  late List<String> ethnicities;
  late bool? hasChildren;
  late String childrenPreference;
  late String hometown;
  late String work;
  late String jobTitle;
  late String school;
  late String educationLevel;
  late String religion;
  late String politicalBelief;
  late String alcoholPreference;
  late String smokePreference;
  late String weedPreference;
  late String drugPreference;

  User() {
    firstName = "";
    lastName = "";
    email = "";
    dob = "";
    zipcode = "";
    city = "";
    state = "";
    country = "";
    gender = "";
    genderPreference = "";
    height = "";
    ethnicities = [];
    hasChildren = null;
    childrenPreference = "";
    hometown = "";
    work = "";
    jobTitle = "";
    school = "";
    educationLevel = "";
    religion = "";
    politicalBelief = "";
    alcoholPreference = "";
    smokePreference = "";
    weedPreference = "";
    drugPreference = "";
  }

  String get getFirstName {
    return firstName;
  }

  set setFirstName(String firstName) {
    this.firstName = firstName;
  }

  String get getLastName {
    return lastName;
  }

  set setLastName(String lastName) {
    this.lastName = lastName;
  }

  String get getEmail {
    return email;
  }

  set setEmail(String email) {
    this.email = email;
  }

  String get getDob {
    return dob;
  }

  set setDob(String dob) {
    this.dob = dob;
  }

  String get getZipcode {
    return zipcode;
  }

  set setZipcode(String zipcode) {
    this.zipcode = zipcode;
  }

  String get getCity {
    return city;
  }

  set setCity(String city) {
    this.city = city;
  }

  String get getState {
    return state;
  }

  set setState(String state) {
    this.state = state;
  }

  String get getCountry {
    return country;
  }

  set setCountry(String country) {
    this.country = country;
  }

  String get getGender {
    return gender;
  }

  set setGender(String gender) {
    this.gender = gender;
  }

  String get getGenderPreference {
    return genderPreference;
  }

  set setGenderPreference(String genderPreference) {
    this.genderPreference = genderPreference;
  }

  String get getHeight {
    return height;
  }

  set setHeight(String height) {
    this.height = height;
  }

  List<String> get getEthnicities {
    return ethnicities;
  }

  set setEthnicities(List<String> ethnicities) {
    this.ethnicities = ethnicities;
  }

  bool? get getHasChildren {
    return hasChildren;
  }

  set setHasChildren(bool? hasChildren) {
    this.hasChildren = hasChildren;
  }

  String get getChildrenPreference {
    return childrenPreference;
  }

  set setChildrenPreference(String childrenPreference) {
    this.childrenPreference = childrenPreference;
  }

  String get getHometown {
    return hometown;
  }

  set setHometown(String hometown) {
    this.hometown = hometown;
  }

  String get getWork {
    return work;
  }

  set setWork(String work) {
    this.work = work;
  }

  String get getJobTitle {
    return jobTitle;
  }

  set setJobTitle(String jobTitle) {
    this.jobTitle = jobTitle;
  }

  String get getSchool {
    return school;
  }

  set setSchool(String school) {
    this.school = school;
  }

  String get getEducationLevel {
    return educationLevel;
  }

  set setEducationLevel(String educationLevel) {
    this.educationLevel = educationLevel;
  }

  String get getReligion {
    return religion;
  }

  set setReligion(String religion) {
    this.religion = religion;
  }

  String get getPoliticalBelief {
    return politicalBelief;
  }

  set setPoliticalBelief(String politicalBelief) {
    this.politicalBelief = politicalBelief;
  }

  String get getAlcoholPreference {
    return alcoholPreference;
  }

  set setAlcoholPreference(String alcoholPreference) {
    this.alcoholPreference = alcoholPreference;
  }

  String get getSmokePreference {
    return smokePreference;
  }

  set setSmokePreference(String smokePreference) {
    this.smokePreference = smokePreference;
  }

  String get getWeedPreference {
    return weedPreference;
  }

  set setWeedPreference(String weedPreference) {
    this.weedPreference = weedPreference;
  }

  String get getDrugPreference {
    return drugPreference;
  }

  set setDrugPreference(String drugPreference) {
    this.drugPreference = drugPreference;
  }
}
