class News {
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String newsUrl;
  final String imageUrl;
  final String content;
  final String publishedAt;

  News(
      {
      this.sourceName,
      this.author,
      this.title,
      this.description,
      this.newsUrl,
      this.imageUrl,
      this.content,
      this.publishedAt});

  factory News.fromMap(Map news) {
    return News(
      sourceName: news['source']['name'],
      author: news['author'],
      content: news['content'],
      description: news['description'],
      imageUrl: news['urlToImage'],
      newsUrl: news['url'],
      publishedAt: news['publishedAt'],
      title: news['title'],
    );
  }
}
