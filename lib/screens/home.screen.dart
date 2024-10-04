import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/logo.widget.dart';
import 'conversation.screen.dart';
import '../common/app.config.dart';
import '../widgets/recent_searches.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), _validateEvaluationPeriod);
  }

  void _validateEvaluationPeriod() {
    final currentDate = DateTime.now();
    final endDate = DateTime(2024, 6, 30);

    if (currentDate.isAfter(endDate)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Evaluation Period Expired'),
            content: const Text(
              'The evaluation period has expired. Please contact the app developer.\nEmail: hi@loonds.com',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background2.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    kPrimaryColorOpacity,
                    BlendMode.srcOver,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Container(
                height: 60.0,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Coming Soon'),
                                content:
                                    const Text('This feature is coming soon!'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.menu_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 60.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWidget(),
                const SizedBox(height: 16.0),
                Container(
                  width: 340.0,
                  height: 60.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(27.0, 0, 0, 0),
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(
                              fontFamily: 'Sora',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              height: 20.0 / 16.0,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Where to?',
                            ),
                          ),
                        ),
                      ),
                      if (!isSearching)
                        SizedBox(
                          width: 120.0,
                          height: 48.0,
                          child: ElevatedButton(
                            onPressed: _onContinuePressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            child: const Text(
                              'Let\'s plan',
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                                height: 12.6 / 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      if (isSearching)
                        Container(
                          height: 48,
                          width: 48,
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Recent searches',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RecentSearches(
                          recentSearches: recentSearches,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onContinuePressed() async {
    setState(() {
      isSearching = true;
    });
    try {
      if (_controller.text.isEmpty) {
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConversationScreen(query: _controller.text),
        ),
      );
    } catch (_) {
    } finally {
      setState(() {
        isSearching = false;
      });
    }
  }
}

const recentSearches = [
  'brasil',
  'hamburg',
  'zakinthos greece',
  'italy',
  'venice',
  'lisboa',
  'greece',
  'meulebeke',
  'ho chi minh',
  'bodrum',
  'las vegas',
  'sasan gir',
  'lisbon',
  'ho chi minh',
  'sarlat-la-canéda',
  'dubrovnik',
  'tulum',
  'near to iskcon temple banglore',
  'milan one day',
  'vancouver',
  'pondicherry',
  'punta del este',
  'madurai',
  'san francisco',
  'vietnam',
  'iskcon temple banglore',
  '1 week trip to manila',
  'goa',
  'bangkok',
  'menorca',
  'vietnam',
  'cumming ga',
  'orlando',
  'bangkok',
  'ho chi minh',
  'pattaya',
  'munnar',
  'porto',
];
