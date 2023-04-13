/// Summarized information of a character.
///  {
//     "id": "0",
//     "author": "Alejandro Escamilla",
//     "width": 5616,
//     "height": 3744,
//     "url": "https://unsplash.com/...",
//     "download_url": "https://picsum.photos/..."
// }
class CharacterSummary {
  CharacterSummary({
    required this.id,
    required this.author,
    required this.url,
  });

  factory CharacterSummary.fromJson(Map<String, dynamic> json) =>
      CharacterSummary(
        id: json['id'],
        author: json['author'],
        url: json['download_url'],
      );

  final String id;
  final String author;
  final String url;
}
