import 'package:flutter/material.dart';
import 'reservesubject.dart' as reserve;
import 'enrolledsubject.dart' as enrolled;
import 'package:akic_pregma/main.dart' as prefix0;

class SubjectMain extends StatefulWidget{

  String student_id;  
  SubjectMain({Key key,this.student_id}) : super(key:key);
  
  @override
  _SubjectMain createState() => _SubjectMain();
} 

class _SubjectMain extends State<SubjectMain> with SingleTickerProviderStateMixin{

  TabController controller;
  
  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync: this,length: 2);
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context ){
    return Scaffold(
          appBar: AppBar(
            title: Text("My Subject"),
               backgroundColor:  Color(0xFFFC6A7F),
               bottom: new TabBar(
                 controller: controller,
                 tabs: <Widget>[
                   new Tab(text: "RESERVED",),
                   new Tab(text: "ENROLLED",),
                 ],
               ),
          ),
          
          body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new reserve.ReserveSubject(student_id:prefix0.student_id),
              new enrolled.EnrolledSubject(student_id:prefix0.student_id),
            ],
          )
    );
  }
}