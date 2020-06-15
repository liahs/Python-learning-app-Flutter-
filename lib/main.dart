import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/fetch_json.dart';
import 'package:quiz/Webpage.dart';
import 'package:quiz/animterCon.dart';
import 'package:shimmer/shimmer.dart';
import 'package:quiz/learn.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Python',
      onGenerateRoute: (settings) {
        if (settings.name == Learn.routeName) {
          final Obj args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return Learn(
                x: args.x,
              );
            },
          );
        }
      },
      home: MyHomePage(),
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          primarySwatch: Colors.orange,
          splashColor: Colors.orange),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AnimaterCon> news(context, data) {
    List<AnimaterCon> list = [];
    for (var i = 0; i < 6; i++) {
      list.add(AnimaterCon(
        time: i+2,
        child: RawMaterialButton(
          fillColor: Colors.orange[200],
          elevation: 4.0,
          padding: EdgeInsets.all(10.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Web(url: data.post[i].url),
                ));
          },
          child: Column(
            children: [
              Text("${data.post[i].title}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(child: Text("source: ${data.post[i].name??"Unknown"}",maxLines: 1,overflow: TextOverflow.ellipsis)),
                  Flexible(child: Text("author: ${data.post[i].author??"Unknown".trim()}",maxLines: 1,overflow: TextOverflow.ellipsis))
                ],
              )
            ],
          ),
        ),
      ));
      
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      
      body: CustomScrollView(
        controller: ScrollController(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.orange[300],
            floating: true,
            pinned: false,
            snap: true,
            elevation: 0.0,
            expandedHeight: 240.0,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(  
                centerTitle: true,
                title:AnimaterCon(
                time: 2,
                child: Text(
                    "Learn Python",
                    style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                    ),
                  ),
            ),
              collapseMode: CollapseMode.parallax,
              background: Image.asset('assets/bc.jpg',fit: BoxFit.fitWidth,),
                 
               
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Colors.orange[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Chapters",
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                HorizontalList(),
                Container(
                  color: Colors.orange[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Top 6 Tech Headline News ",
                          style: TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 700,
                  child: Card(
                    margin: EdgeInsets.all(0.0),
                    color: Colors.white,
                    child: FutureBuilder<PostList>(
                      future: fetchPost(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: news(context,snapshot.data)
                              ); //Column(
                          //mainAxisSize: MainAxisSize.max, children: l));
                        } else if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.only(top:15.0),
                            child: Align(
                              alignment: Alignment.topCenter,

                              child: FittedBox
                                      (fit: BoxFit.fill,
                                        child: Image.asset("assets/noi.gif",fit:BoxFit.fill,scale: 1.5,))),
                          );
                        }
                        // By default, show a loading spinner.
                        return Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: SizedBox(
                              width: 200.0,
                              height: 100.0,
                              child: Shimmer.fromColors(
                                baseColor: Colors.black,
                                highlightColor: Colors.orange[300],
                                child: Text(
                                  'loading .....',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Text(' I am Drawer'),
            curve: SawTooth(12),
          ),
        ],
      ))
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}

class Obj {
  final int x;
  Obj(this.x);
}

class HorizontalList extends StatelessWidget {
  List<Widget> hlist(context){
    List<Widget> list=[];
    for(var i=0;i<title.length;i++){
      list.add(SizedBox(width: 10,));
      list.add(
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Learn.routeName,
         arguments: Obj(i));
          },
          child:Container(
            width: 110,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              
              color: Colors.orange[200],
              border: Border.all(color: Colors.white,width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(12))
            ),

            child: Text(title[i],style: TextStyle(inherit: false,color: Colors.black,fontSize: 15,fontFamily: "Ubuntu"),),
        )
      ));
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
      color: Colors.orange[200],
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:hlist(context) 
      ),
    );
  }
}
