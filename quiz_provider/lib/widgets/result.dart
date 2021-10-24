import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback  resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 10) {
      resultText = 'Il faudrait penser à revoir les règles de sécurité sanitaire :(';
    } else if (resultScore <= 20) {
      resultText = 'Attention! Certaines règles ne sont pas assimilées';
    } else {
      resultText = 'Très bien :)';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 61,
              fontWeight: FontWeight.w300,
              letterSpacing: -0.5,),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            child: Text(
              'Rejouer le quiz!',
            ),
            //color: Colors.blueGrey,
            //textColor: Colors.black,
            onPressed: resetHandler,
          ),
        ],
      ),
    );
  }
}