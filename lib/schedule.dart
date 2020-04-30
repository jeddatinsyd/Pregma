import 'package:flutter/material.dart';
import 'scheduleprevious.dart' as previous;
import 'schedulecurrent.dart' as current;
import 'package:akic_pregma/main.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class Schedule extends StatefulWidget{

  String student_id;  
  Schedule({Key key,this.student_id}) : super(key:key);
  
  @override
  _Schedule createState() => _Schedule();
} 

class _Schedule extends State<Schedule> with SingleTickerProviderStateMixin{

  TabController controller;

    String semester_name = "semester ",
            year = "year ";

      Future<String> semester(String id) async {

        var response = await http.get(
        Uri.encodeFull(
            "http://10.0.2.2/pregma/api/getCurrentSem.php?student_id="+id+" "),
              
            headers: {"Accept": "application/json"});
            var data2 = json.decode(response.body);
            setState(() 
            {
              if(data2 != null) {
                semester_name= data2[0]['trimester'];
                year = data2[0]['year'];
              }
              else{
                semester_name='null';
              }
            }
            
            ); 
            print(data2);
            return data2;
            //return data2;
        }



  @override
  void initState(){
    super.initState();

    controller = new TabController(vsync: this,length: 2);
    setState(() {
            semester(widget.student_id);
    });
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
            title: Text("Schedule"),
               backgroundColor:  Color(0xff622F74),
               bottom: new TabBar(
                 controller: controller,
                 tabs: <Widget>[
                    new Tab(text: "CURRENT",),
                   new Tab(text: semester_name+'  '+'Semester'+' , '+year,
                   ),
                  
                 ],
               ),
          ),
          
          body: new TabBarView(
            controller: controller,
            children: <Widget>[
                new current.ScheduleCurrent(student_id:prefix0.student_id),
              new previous.SchedulePrevious(student_id:prefix0.student_id),
            
            ],
          )
    );
  }
}