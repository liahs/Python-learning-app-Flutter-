import 'package:flutter/material.dart';
import 'package:quiz/parse.dart';
 List<String> title = [
    "Introduction",
    "Variables",
    "Numbers",
    "Strings",
    "Conditional",
    "Functions",
    "Lists",
    "Dictionaries",
    "Sets",
    "OOPs"
  ];

class Learn extends StatefulWidget {
  Learn({Key key, this.x}) : super(key: key);
  static final routeName = '/learn';
  final int x;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Learn> {
  int x;
  bool level;
  int point = 120;

  @override
  void initState() {
    super.initState();
    level = false;
    x = widget.x;
  }

 

  List<Widget> list(data) {
    var dat = data.intro;
    switch (x) {
      case 0:
        dat = data.intro;
        break;
      case 1:
        dat = data.variables;
        break;
      case 2:
        dat = data.numbers;
        break;
      case 3:
        dat = data.strings;
        break;
      case 4:
        dat = data.conditional;
        break;
      case 5:
        dat = data.functions;
        break;
      case 6:
        dat = data.list;
        break;
        case 7:
        dat=data.dictionaries;
        break;
        case 8:
        dat=data.sets;
        break;
        case 9:
        dat=data.oops;
        break;
      default:
        dat = data.intro;
    }

    int l = dat.length;
    List<Widget> datares = [];
    for (var i = 0; i < l; i++) {
      Widget x = Column(children: [
        Text(dat[i]['title'],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 6,
        ),
        Text(dat[i]['content'],
            textAlign: TextAlign.left,
            overflow: TextOverflow.visible,
            softWrap: true,
            textScaleFactor: 1.2,
            style: TextStyle(fontFamily: "Arial")),
        SizedBox(
          height: 10,
        ),
        Text(dat[i]['code'], style: TextStyle(color: Colors.grey[500])),
        SizedBox(
          height: 10,
        ),
      ]);
      datares.add(x);
    }
    return datares;
  }

  Future<void> _neverSatisfied(ctxt) async {
    return showDialog<void>(
      context: ctxt,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Point not enough'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Total :100 point'),
                Text('Need: 50 point '),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Try again!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListView(
      children: <Widget>[
        Stack(
          
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0),bottomRight: Radius.circular(100.0) ),
              child:Image.asset("assets/bc.jpg",fit: BoxFit.cover,height: 200,width: double.infinity,)
              ),
            Opacity(
              opacity: 0.7,
                          child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        IconButton(
                          iconSize: 35,
                          color: Colors.black54,
                          onPressed: () {
                            setState(() {
                              if (x == 0) {
                                Navigator.pop(context);
                              }
                              x > 0 ? x-- : x = 0;
                            });
                          },
                          icon: x == 0 ? Icon(Icons.home) : Icon(Icons.arrow_back),
                        ),
                        Spacer(),
                        IconButton(
                          iconSize: 35,
                          color: Colors.black54,
                          onPressed: () {
                            setState(() {
                              x <= 9 ? x++ : x = 0;
                            });
                          },
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),
                    Text(title[x],style: TextStyle(fontSize: 44.0),),
                  ],
                ),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.1, 0.3),
                        tileMode: TileMode.mirror,
                        colors: [Colors.orange[500], Colors.white]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0))),
              ),
            ),
            
          ],
        ),
        FutureBuilder<Data>(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: list(snapshot.data),
                    ),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[],
          ),
        )
      ],
    ));
  }
}
