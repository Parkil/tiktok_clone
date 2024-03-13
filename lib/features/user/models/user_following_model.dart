class UserFollowingModel {
  final int followers;
  final int following;
  final int likes;

  UserFollowingModel({
    required this.followers,
    required this.following,
    required this.likes,
  });

  UserFollowingModel copyWith({
    int? followers,
    int? following,
    int? likes,
  }) {
    return UserFollowingModel(
      followers: followers ?? this.followers,
      following: following ?? this.following,
      likes: likes ?? this.likes,
    );
  }
}
