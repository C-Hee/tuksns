class CommentModel {
  int? id;
  String? name;
  int? feedId;
  String? content;
  DateTime? createdAt;

  CommentModel.parse(Map m) {
    id = m['id'];
    content = m['content'];
    createdAt = DateTime.parse(m['created_at']);
    name = m['user_name'];
    feedId = m['feed_id'];
  }
}
