import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SlideAnims extends StatefulWidget {
  SlideAnims({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SlideAnimsState createState() => _SlideAnimsState();
}

class _SlideAnimsState extends State<SlideAnims>
    with SingleTickerProviderStateMixin {
  static double x = 0.0, y = 0.0, z = 0.0;
  Animation animation;
  AnimationController animController;
  String image = 'assets/left.png';

  //Matrix4 matrix1 = Matrix4.translationValues(width*1.0, 0.0, 0.0),
  // matrix2 = Matrix4.translationValues(0.0, 1.0*height*2, 0.0);

  @override
  void initState() {
    animController = AnimationController(duration: Duration(milliseconds: 3500), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(parent: animController, curve: Curves.fastOutSlowIn));
    // animController.forward().then((val){
    // animController.reset();
    //});
  }

  void setAnimStyle(String im,double begin,double end) {
    //if(animController.status==AnimationStatus.forward)
    animController.reset();
    setState(() {
      image = im;
      animation = Tween(begin: begin,end: end)
          .animate(CurvedAnimation(parent:animController,
          curve: Curves.fastOutSlowIn));
      animController.forward();
      print(animController.status);
      //print('x $x $X\ny $y\nz $z\n $im\n$begin\n$end');
    });
  }

  Widget getButton(String text, VoidCallback onPress) {
    return Container(
      height: 60.0,
      width: 190.0,
      margin: EdgeInsets.all(5.0),
      child: CupertinoButton(
        child: Text(text, textAlign: TextAlign.center,textDirection: TextDirection.ltr,),
        onPressed: onPress,
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // print(width);

//    print(animation.value);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: height * 4 / 10,
            child: Center(
              child: AnimatedBuilder(
                animation: animation,
                builder: (BuildContext ctx, Widget child) {
                  return Transform(
                    //for X-Axis
                    transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                    // for Y-Axis
//                    transform: Matrix4.translationValues(0.0, animation.value*height*.1, 0.0),
                    child: SizedBox(
                      height: 180.0,
                      child: Image.asset(image),
                    ),
                  );
                },
              ),
            ),
          ),
          Wrap(
            children: <Widget>[
              getButton('Left In', () {setAnimStyle('assets/left.png',-1.0,0.0);}),
              getButton('Left Out', () {setAnimStyle('assets/left.png',0.0,1.0);}),
              getButton('Right In', () {setAnimStyle('assets/right.png',1.0,0.0);}),
              getButton('Right Out', () {setAnimStyle('assets/right.png',0.0,-1.0);}),
              getButton('Top In', () {setAnimStyle('assets/top_view_up.png',1.5,0.0);}),
              getButton('Top Out', () {setAnimStyle('assets/top_view_up.png',0.0,-4.0);}),
              getButton('Bottom In', () {setAnimStyle('assets/top_view_down.png',-4.0,0.0);}),
              getButton('Bottom Out', () {setAnimStyle('assets/top_view_down.png',0.0,41.0);}),
            ],
          )
        ],
      ),
    );
  }
}