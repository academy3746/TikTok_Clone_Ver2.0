class UserProfileModel {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final String link;
  final String birthday;

  UserProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bio,
    required this.link,
    required this.birthday
  });

  UserProfileModel.empty()
      : uid = "",
        name = "",
        email = "",
        bio = "",
        link = "",
        birthday = "";

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "bio": bio,
      "link": link,
      "birthday": birthday
    };
  }
}
