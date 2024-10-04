import 'package:flutter/material.dart';

import '../common/app.config.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.0,
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(180.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(27.0, 0, 0, 0),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  height: 20.0 / 16.0,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Where to?',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 96.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'LET\'S ROAM',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.w700,
                    fontSize: 10.0,
                    height: 12.6 / 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}