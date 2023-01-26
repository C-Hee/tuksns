class FeedModel {
  int? id;
  String? name;
  int? imageId;
  String? content;
  DateTime? createdAt;
  bool? isMe;
  int? type;
  String? title;

  FeedModel.parse(Map m) {
    id = m['id'];
    title = m['title'];
    content = m['content'];
    createdAt = DateTime.parse(m['created_at']);
    name = m['user_name'];
    imageId = m['image_id'];
    isMe = m['is_me'];
    type = m['type'];
  }
}
