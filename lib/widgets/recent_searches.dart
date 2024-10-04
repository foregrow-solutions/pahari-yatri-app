import 'package:flutter/material.dart';
import 'dart:async';

import '../screens/conversation.screen.dart';

class RecentSearches extends StatefulWidget {
  final List<String> recentSearches;

  const RecentSearches({Key? key, required this.recentSearches})
      : super(key: key);

  @override
  _RecentSearchesState createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.recentSearches.length;
        _scrollToIndex(_currentIndex);
      });
    });
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * 100.0, // Adjust the value as needed based on item width
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      color: Colors.transparent,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: widget.recentSearches.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConversationScreen(
                              query: widget.recentSearches[index])));
                },
                child: Text(
                  widget.recentSearches[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: 1.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 24.0,
              )
            ],
          );
        },
      ),
    );
  }
}
