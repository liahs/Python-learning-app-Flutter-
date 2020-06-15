import 'package:flutter/material.dart';

class AnimaterCon extends StatefulWidget{
  final child;
  final int time;
  AnimaterCon({@required this.child,this.time});
  AnimaterConState createState()=>AnimaterConState();

}

class AnimaterConState extends State<AnimaterCon> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;

  @override
  void initState(){
    _controller=AnimationController(vsync: this,duration: Duration(seconds:widget.time));
    _animation=Tween(begin: 0.0,end: 1.0).animate(_controller);
  }
 @override
 void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    _controller.forward();
    return FadeTransition(
      opacity:_animation,
      child:widget.child,
    );
  }
}
