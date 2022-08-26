class VideoModal {
  String id;
  String title;
  String file;
  String thumbnail;
  DateTime createdAt;
  String location;

  VideoModal({
    required this.id,
    required this.title,
    required this.file,
    required this.thumbnail,
    required this.createdAt,
    required this.location,
  });

  factory VideoModal.fromJson(Map json) {
    return VideoModal(
      id: json['id'],
      title: json['title'],
      file: json['video'],
      thumbnail: json['thumbnail'],
      createdAt: DateTime.parse(json['created_at']),
      location: json['location']??'no location',
    );
  }
}
