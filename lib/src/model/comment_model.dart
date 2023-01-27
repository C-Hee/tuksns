class CommentModel {
  int? id;
  int? user_id;
  int? feed_id;
  String? content;
  String? user_name;
  DateTime? createdAt;
  bool? isMe;

  CommentModel.parse(Map m) {
    id = m['id'];
    content = m['content'];
    user_id = m['user_id'];
    feed_id = m['feed_id'];
    user_name = m['user_name'];
    createdAt = DateTime.parse(m['created_at']);
    isMe = m['isMe'];
  }
}
