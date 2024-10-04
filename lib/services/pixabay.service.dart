import 'dart:convert';
import '../common/app.config.dart';
import 'package:http/http.dart' as http;

Future<List<String>> fetchPixabayImages(String prompt) async {
  const apiKey = pixabayAPIKey;
  const baseUrl = 'https://pixabay.com/api/';
  final response = await http.get(Uri.parse('$baseUrl?'
      'key=$apiKey'
      '&q=${Uri.encodeComponent(prompt)}'
      '&image_type=photo'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<dynamic> hits = data['hits'];

    final List<String> imageUrls = hits.map<String>((hit) => hit['webformatURL']).toList();

    return imageUrls;
  } else {
    throw Exception('Failed to fetch images from Pixabay');
  }
}

Future<String> replaceImageTags(String body) async {
  final pattern = RegExp(r'\[IMG\(([^)]+)\)\]');
  final matches = pattern.allMatches(body);

  String modifiedBody = body;

  for (final match in matches) {
    final tag = match.group(1) ?? 'travel landscape';
    print(tag);
    final imageUrl = (await fetchPixabayImages(tag))[0];
    final imageReference = '![$tag]($imageUrl)';
    modifiedBody = modifiedBody.replaceFirst(match.group(0)!, imageReference);
  }

  return modifiedBody;
}