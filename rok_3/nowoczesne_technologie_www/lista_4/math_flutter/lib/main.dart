import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  late TextEditingController myController;
  var ast = SyntaxTree(greenRoot: TexParser('', TexParserSettings()).parse());
  final decorationColor = Color.fromRGBO(73, 93, 75, 1);
  RegExp regExp = RegExp(r"\$[^$]+\$");
  String s =
      r"Nikt nie udowodnił jeszcze, że $2 +2 \neq 5$, ponieważ czy znasz kogokolwiek kto wiedziałby, że $\sum 4^n = 16$ dla wszystkich $n \in {Q}$. To nie jest taka łatwa sprawa, biorąc pod uwagę, że $1^3 = -1$. "
      r" Oczywiście wszystko w odpowiedniej grupie. Albo pierścieniu $P$. Jeden pierścień $P$ by wszystkimi $\frac{\alpha g^2}{\omega^5} e^{[ -0.74\bigl\{\frac{\omega U_\omega 19.5}{g}\bigr\}^{\!-4}\,]}$.";
  var list = <Widget>[];
  var screenWidth = 0.0;

  @override
  void initState() {
    myController = TextEditingController();
    myController.addListener(() {
      setState(() {
        parse(myController.text);
      });
    });
    super.initState();
  }

  List<Widget> getLatex(List<Widget> list) {
    return this.list;
  }

  void parse(String input) {
    list.clear();
    s = myController.text;
    Iterable<Match> matches = regExp.allMatches(s);
    var lastEnd = 0;
    for (Match match in matches) {
      list.add(Text(s.substring(lastEnd, match.start - 1) + " "));
      list.add(Math.tex(s.substring(match.start + 1, match.end - 1),
          textStyle: TextStyle(fontSize: 20), mathStyle: MathStyle.text));
      lastEnd = match.end;
    }

    if (lastEnd < s.length) {
      list.add(Text(s.substring(lastEnd, s.length)));
    }
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tmp = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.4,
            child: TextField(
              controller: myController,
              maxLines: 19,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Insert expression",
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 32, width: 32),
      Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: decorationColor)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Output:", style: TextStyle(color: decorationColor)),
              SizedBox(height: 8),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 8,
                children: getLatex(list),
              ),
            ],
          ),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Plain to Latex '),
      ),
      body: Center(
        child: Container(
            child: getMainContainer(tmp, MediaQuery.of(context).size.width)),
      ),
    );
  }

  Widget getMainContainer(List<Widget> kids, double size) {
    if (size < 900) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center, children: kids);
    } else {
      return Row(
        children: kids,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      );
    }
  }
}
