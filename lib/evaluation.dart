import 'package:flutter/material.dart';
import 'evaluationcompleted.dart' as completed;
import 'evaluationpending.dart' as pending;
import 'package:akic_pregma/main.dart' as prefix0;


class Evaluation extends StatefulWidget{
  String student_id;

  Evaluation({Key key,this.student_id}) : super(key:key);
  
  @override
  _Evaluation createState() =>  _Evaluation();
}

class _Evaluation extends State<Evaluation> with SingleTickerProviderStateMixin{ 
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
            title: Text("Academic Evaluation"),
               backgroundColor:  Color(0xff26cb3cc),
               bottom: new TabBar(
                 controller: controller,
                 tabs: <Widget>[
                   new Tab(text: "COMPLETED",),
                   new Tab(text: "PENDING",),
                 ],
               ),
          ),
          body: new TabBarView(
            controller: controller,
            children: <Widget>[
              new completed.EvaluationCompleted(student_id:prefix0.student_id),
              new pending.EvaluationPending(student_id:prefix0.student_id),
            ],
          )
    );
  }
}

