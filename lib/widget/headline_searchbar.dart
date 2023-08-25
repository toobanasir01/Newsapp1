import 'package:flutter/material.dart';
import 'package:news_app/controller/headlines_controller.dart';

class HeadlineSearchBar extends StatefulWidget {
  final List<TopHeadline> search;
  const HeadlineSearchBar({super.key, required this.search});

  @override
  State<HeadlineSearchBar> createState() => _HeadlineSearchBarState();
}

class _HeadlineSearchBarState extends State<HeadlineSearchBar> {
  final TopHeadline a = TopHeadline();

  List<TopHeadline>? searchArtcles = [];
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
          style: const TextStyle(fontSize: 50),
          decoration: const InputDecoration(
            helperText: "Serch",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              searchArtcles = widget.search
                  .where((element) =>
                      element.getArticles2("in").toString().contains(value))
                  .toList();
            });
          }),
    );
  }
}

// void main() {
//   final ApiServices a = ApiServices();
//   print(a.getArticles2());
// }
