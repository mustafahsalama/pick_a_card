import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StackedList extends StatefulWidget {
  const StackedList({super.key});

  @override
  State<StackedList> createState() => _StackedListState();
}

class _StackedListState extends State<StackedList>

with TickerProviderStateMixin
 {
Animation<double>? _animation;
AnimationController? _animationController;

var cardData = [("Card 1" , Colors.blue), 
("Card 2" , Colors.pink), 
("Card 3" , Colors.blueAccent), ("Card 4" , Colors.blue), 
("Card 5" , Colors.amber), 
("Card 6" , Colors.teal), 
("Card 7" , Colors.purple), 
];

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(vsync: 
    
    this ,duration: const Duration(milliseconds: 350)
    );

    _animation = Tween(begin: 0.5 ,end: 1.0).animate(_animationController!);
  }
forward(){
  _animationController!.stop();
  _animationController!.forward();
}
reverse(){
    _animationController!.stop();
  _animationController!.reverse();
}


@override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
int?  selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stacked Listview"),
      ),
      body:NotificationListener<ScrollNotification>( 
          onNotification: (ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.forward) {
      reverse();
      } else if (notification.direction == ScrollDirection.reverse) {
       forward();
      }
    }

    // Returning null (or false) to
    // "allow the notification to continue to be dispatched to further ancestors".
    return false;
  },
        child: ListView.builder(
          itemCount: cardData.length,
          itemBuilder: (BuildContext context, int index) {

            if (selectedIndex!=null) {
              
            }
            return AnimatedBuilder(
animation: _animation!,
              builder: (context ,child) {
                return Align(
                        heightFactor: _animation!.value,
                  child: Padding(padding: const EdgeInsets.all(4) ,
                  child: Material(
                    shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(10)
                    ),
                        elevation: 5, 
                        child: ListTile(
                          onTap: (){
                // reverse();
                if (_animation!.value<=.5) {
                    forward();
                }else {
                  reverse();
                }
              
                          },
                           shape: RoundedRectangleBorder( 
                      borderRadius: BorderRadius.circular(10)
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 18
                    ),
                    tileColor:cardData[index].$2 as Color,

                    title: Text(cardData[index].$1),
                        ),
                        
                      
                  ), 
                  
                  
                  
                  ),
                );
              }
            );
          },
        ),
      ),
    );
  }
}