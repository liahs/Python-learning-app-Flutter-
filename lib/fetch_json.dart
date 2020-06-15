import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<PostList> fetchPost() async {
  var response = await http.get('https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=8695dcbb9ee34d0893c8a8fffb272213');

  if (response.statusCode == 200) {
    return PostList.fromJson(json.decode(response.body));
  } else {
    print('error');
    throw Exception('Failed to load post');
  }
}

class Post {
  final String name;
  final String title;
  final String  author;
  final String url;
  Post({this.name,this.title,this.author,this.url});
  factory Post.fromJson(json) {
    return Post(
     name:json['source']['name'],
     title:json['title'],
     author: json['author'],
     url: json['url']
    );
  }
}

class PostList{
  final List<Post> post;
  PostList({this.post});
  factory PostList.fromJson(Map<String,dynamic> json){
    List<Post> po=[];
    for(var i=0;i<6;i++){
      var article=json['articles'][i];
      po.add(Post.fromJson(article));
    }
    return PostList(post:po);
  }
}
