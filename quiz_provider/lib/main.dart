import 'package:flutter/material.dart';
import '/providers/main_provider.dart';
import '/providers/providers.dart';
import '/providers/questions_provider.dart';
import 'package:provider/provider.dart';
import 'widgets/quiz.dart';
import 'widgets/result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();

}

class _MyApp extends State<MyApp>{
  static const String _TITLE = 'TP2 Flutter Application 1 - COVID quiz';
  //static const myPrimaryColor = const Color(0xFFE91E63);
  MyTheme currentTheme = MyTheme();

  @override
  void initState(){
    super.initState();
    currentTheme.addListener(() {
      print('Theme changes');
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: currentTheme.currentTheme(),
        home: Scaffold(
          appBar: AppBar(
            title: Text(_TITLE),
          ),
          body: Consumer2<MainProvider, QuestionsProvider>(
            builder: (BuildContext context, MainProvider mainProvider,
                QuestionsProvider questionsProvider, _) {
              if (mainProvider.questionIndex <
                  questionsProvider.questions.length) {
                return Quiz(
                  answerQuestion: mainProvider.answerQuestion,
                  questionIndex: mainProvider.questionIndex,
                  questions: questionsProvider.questions,
                );
              }
              return Result(mainProvider.totalScore, mainProvider.resetQuiz);
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              currentTheme.switchTheme();
            },
            label: Text('Switch Theme'),
            icon: Icon(Icons.brightness_high),
          ),
        ),
      ),
    );
  }
}



class MyTheme with ChangeNotifier {
  static bool _isDark = true;

  ThemeMode currentTheme(){
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}