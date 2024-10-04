import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 279.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Pahari Yatri',
              style: TextStyle(
                fontSize: 29.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sora',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(
                'Your personal AI travel planner',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Sora',
                  color: Colors.white,
                ),
              ),
              Text(' | ', style: TextStyle(fontSize: 14, color: Colors.white)),

            ],
          ),
        ],
      ),
    );
  }


}