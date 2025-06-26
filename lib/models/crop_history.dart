class CropHistory {
  final String cropName;
  final DateTime dateAnalyzed;
  final String analysisType;
  final String resultSummary;
  final String imageUrl;

  CropHistory({
    required this.cropName,
    required this.dateAnalyzed,
    required this.analysisType,
    required this.resultSummary,
    required this.imageUrl,
  });
}

class NewsItem {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime publishDate;

  NewsItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishDate,
  });
}
