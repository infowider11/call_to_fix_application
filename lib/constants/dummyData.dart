import 'dart:math';

List dummyNewsData = [
  {
    'id':'2',
    'file_type':'image',
    'file': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'title': 'Lorem Ipsum',
    'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
    'country': 'India',
    'thumbnail': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'created_at': DateTime.now().subtract(Duration(hours: Random().nextInt(15000))).toString(),

  },
  {
    'id':'2',
    'file_type':'image',
    'file': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'title': 'Lorem Ipsum',
    'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
    'thumbnail': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'created_at': DateTime.now().subtract(Duration(hours: Random().nextInt(15000))).toString(),
    'country': 'India',
  },
  {
    'id':'3',
    'file_type':'2',
    'file': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'title': 'Lorem Ipsum',
    'thumbnail': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
    'file': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'created_at': DateTime.now().subtract(Duration(hours: Random().nextInt(15000))).toString(),
    'country': 'India',
  },
  {
    'id':'4',
    'file_type':'2',
    'file': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'title': 'Lorem Ipsum',
    'thumbnail': 'https://img.freepik.com/free-vector/breaking-news-template_23-2148507392.jpg?w=2000',
    'description': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
    'created_at': DateTime.now().subtract(Duration(hours: Random().nextInt(15000))).toString(),
    'country': 'India',
  },
];