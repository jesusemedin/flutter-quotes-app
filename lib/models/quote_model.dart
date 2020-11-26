class Quote{

  String id;
  String phrase;
  String author;
  String tag;

  Quote({this.phrase, this.author, this.tag});

  Quote.fromJson( Map<String, dynamic> json ){
    id      = json['_id'];
    phrase  = json['content'];
    author  = json['author'];
    tag     = json['tags'][0].replaceAll('-', ' ').toUpperCase();
  }

}