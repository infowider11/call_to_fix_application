enum NewsFileType{
  image, video
}

class NewsModal {
  String id;
  NewsFileType fileType;
  String file;
  String thumbnail;
  String location;
  DateTime createdAt;
  String title;
  String description;
  bool containsJob;

  NewsModal({
    required this.id,
    required this.fileType,
    required this.file,
    required this.thumbnail,
    required this.location,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.containsJob,
  });

  factory NewsModal.fromJson(Map<String, dynamic> json) {
    return NewsModal(
      id: json['id'],
      fileType: json['type']=='1'?NewsFileType.image:NewsFileType.video,
      file: json['file'],
      thumbnail: json['thumbnail']??'',
      location: json['location']??'no location',
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'],
      description: json['description'],
      containsJob: json['contain_jobs']==1?true:false
    );
  }
}
