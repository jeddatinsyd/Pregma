import 'package:flutter/material.dart';
import 'CustomShapeClipper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EvaluationCompleted extends StatefulWidget{

  String student_id;  
  EvaluationCompleted({Key key,this.student_id}) : super(key:key);
  
  @override
  _EvaluationCompleted createState() => _EvaluationCompleted();
} 

class _EvaluationCompleted extends State<EvaluationCompleted>{


 Future<List> getData(String id) async{
    final response=await http.get("http://10.0.2.2/pregma/api/getEvaluation.php?student_id="+id+" ");                                       
    return json.decode(response.body);
  }
        @override
        void  initState(){
          super.initState();
          setState(() {
            getData(widget.student_id);
          });
        } 

  @override 
  Widget build(BuildContext context ){  
    return new Scaffold(
       body:  FutureBuilder<List>(
          future: getData(widget.student_id),
            builder: (ctx,ss){
              if(ss.hasError)
              {
                print("error");
              }
              if(ss.hasData){
                return Items(list:ss.data);
              }
              else{
                return CircularProgressIndicator();
              }
            },
          ),
    );
  }
}


class Items extends StatelessWidget {
  List list;
  Items({this.list});
  @override
  Widget build(BuildContext context){
    return  ListView.builder(
      
      itemCount: list==null?0:list.length,
      itemBuilder: (ctx,i){
      var postItem = list[i];

      return Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                 list[i]['subject_code']+' : '+list[i]['description'],
                 style: TextStyle(
                   fontSize: 20.0,
                   color: Colors.black,
                 ),
              ),

              SizedBox(
                
                height: 10.0,
              ),

              Text('Units:'+' '+
                list[i]['units'],
                style: TextStyle(
                   fontSize: 16.0,
                   color: Colors.black,
                 ),
              ),
              Text('Grade: '+' '+
                list[i]['grade_name'],
                style: TextStyle(
                   fontSize: 16.0,
                   color: Colors.black,
                 ),
              ),

            ],
          ),
        ),
      );          
      }
    );
  }
}