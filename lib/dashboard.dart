import 'package:akic_pregma/balance.dart';
import 'package:akic_pregma/evaluation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'main.dart';
import 'userprofile.dart';
import 'offeredsubject.dart';
import 'balance.dart';
import 'evaluation.dart';
import 'schedule.dart';

const PrimaryColor = const Color(0xFF151026);

class DashboardHome extends StatelessWidget{
  
  @override

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),

    );
  }
}

class Dashboard extends StatelessWidget {

Dashboard({this.student_id});
String student_id='';


 //Dashboard({Key key, this.student_id}) : super(key:key);

  Material MyItems(IconData icon, String heading, int color) {
    return Material(
      
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        heading,
                        style: TextStyle(
                          color: new Color(color),
                          fontSize: 20.0,
                        ),
                      ),
                    ),

                    Material(
                      color: new Color(color),
                      borderRadius: BorderRadius.circular(24.0),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 30.0,
                          ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF18D191),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 80.0),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
           // MyItems(Icons.person, "Profile", 0xffed622b),
            GestureDetector(
              child: MyItems(Icons.person, 'Profile',0xfff57c00 ),
              
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(BuildContext context )=>UserProfile(student_id:this.student_id)
                ),
              ),
       
            ),

           // MyItems(Icons.bookmark, "Evaluation", 0xff26cb3cc),
            GestureDetector(
              child: MyItems(Icons.bookmark, "Evaluation", 0xff26cb3cc),
            
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(BuildContext context )=>Evaluation(student_id:this.student_id)
                  //builder:(BuildContext context )=>Subject(student_id:this.student_id)
                ),
              ),
            ),
                    
            GestureDetector(
              child: MyItems(Icons.subject, "Offered Subject", 0xffff3266),
            
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(BuildContext context )=>offeredSubject(student_id:this.student_id)
                  //builder:(BuildContext context )=>Subject(student_id:this.student_id)
                ),
              ),
            ),
            
           // MyItems(Icons.schedule, "Class Schedule", 0xff622F74),
            //MyItems(Icons.attach_money, "Balance", 0xff3399fe),
            GestureDetector(
              child: MyItems(Icons.calendar_today, "Class Schedule", 0xff622F74),
            
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(BuildContext context )=>Schedule(student_id:this.student_id)
                ),
              ),
            ),


            GestureDetector(
              child: MyItems(Icons.attach_money, "Balance", 0xff3399fe),
            
              onTap: ()=>Navigator.of(context).push(
                MaterialPageRoute(
                  builder:(BuildContext context )=>Balance(student_id:this.student_id)
                ),
              ),
            ),

           // MyItems(Icons.settings, "Logout", 0xfff4c83f),
            GestureDetector(
              child: MyItems(Icons.settings, "Logout", 0xfff4c83f),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => MyHomePage(),
                //     ));
              //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomePage(),), (e) => false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
              },
            )
            
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
            StaggeredTile.extent(1, 150),
          ],
        ),
      ),
    );
  }
}
