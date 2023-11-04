class User {
  late String avatar;
  late String name;
  late bool isOnline;

  User({
    required this.avatar,
    required this.name,
    required this.isOnline,
  });
}

List<User> users = [
  User(
    avatar: "assets/avatars/avatar_1.png",
    name: "Trần Quang Huy",
    isOnline: true,
  ),
  User(
    avatar: "assets/avatars/avatar_2.png",
    name: "Đặng Văn Anh Nguyên",
    isOnline: false,
  ),
];
