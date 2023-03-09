class User {
  late String firstName;
  late String lastName;
  late String email;
  late String dob;
  late String gender;
  late String sexuality;
  late String genderPreference;
  late String experiencePreference;
  late String childrenPreference;
  late String height;
  late String zipcode;
  late String city;
  late String state;
  late String country;
  late String drugPreference;
  late String weedPreference;
  late String smokePreference;
  late String alcoholPreference;

  User() {
    firstName = "";
    lastName = "";
    email = "";
    dob = "";
    gender = "";
    sexuality = "";
    genderPreference = "";
    experiencePreference = "";
    childrenPreference = "";
    height = "";
    zipcode = "";
    city = "";
    state = "";
    country = "";
    drugPreference = "";
    weedPreference = "";
    smokePreference = "";
    alcoholPreference = "";
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

  String get setGender {
    return gender;
  }

  set setGender(String gender) {
    this.gender = gender;
  }

  String get getSexuality {
    return sexuality;
  }

  set setSexuality(String sexuality) {
    this.sexuality = sexuality;
  }

  String get getGenderPreference {
    return genderPreference;
  }

  set setGenderPreference(String genderPreference) {
    this.genderPreference = genderPreference;
  }

  String get getExperiencePreference {
    return experiencePreference;
  }

  set setExperiencePreference(String experiencePreference) {
    this.experiencePreference = experiencePreference;
  }

  String get getChildrenPreference {
    return childrenPreference;
  }

  set setChildrenPreference(String childrenPreference) {
    this.childrenPreference = childrenPreference;
  }

  String get getHeight {
    return height;
  }

  set setHeight(String height) {
    this.height = height;
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

  String get getDrugPreference {
    return drugPreference;
  }

  set setDrugPreference(String drugPreference) {
    this.drugPreference = drugPreference;
  }

  String get getWeedPreference {
    return weedPreference;
  }

  set setWeedPreference(String weedPreference) {
    this.weedPreference = weedPreference;
  }

  String get getSmokePreference {
    return smokePreference;
  }

  set setSmokePreference(String smokePreference) {
    this.smokePreference = smokePreference;
  }

  String get getAlcoholPreference {
    return alcoholPreference;
  }

  set setAlcoholPreference(String alcoholPreference) {
    this.alcoholPreference = alcoholPreference;
  }
}
