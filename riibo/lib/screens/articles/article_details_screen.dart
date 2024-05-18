import 'package:flutter/cupertino.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final String articleId;
  const ArticleDetailsScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(widget.articleId),
      ),
    );
  }
}
