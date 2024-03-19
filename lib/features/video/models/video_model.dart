class VideoModel {
  final String id;
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creator;
  final int likes;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.likes,
    required this.comments,
    required this.creatorUid,
    required this.createdAt,
    required this.creator,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'likes': likes,
      'comments': comments,
      'creatorUid': creatorUid,
      'createdAt': createdAt,
      'creator': creator,
    };
  }

  VideoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        fileUrl = json['fileUrl'],
        thumbnailUrl = json['thumbnailUrl'],
        creatorUid = json['creatorUid'],
        creator = json['creator'],
        likes = json['likes'],
        comments = json['comments'],
        createdAt = json['createdAt'];
}
