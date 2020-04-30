import 'package:akic_pregma/removereserve.dart';
import 'package:flutter/material.dart';
import 'CustomShapeClipper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:akic_pregma/main.dart' as prefix0;
import 'details.dart';
import 'masterlist.dart';

class HandledCourses extends StatefulWidget{

  String student_id;  
  HandledCourses({Key key,this.student_id}) : super(key:key);
  
  @override
  _HandledCourses createState() => _HandledCourses();
} 

class _HandledCourses extends State<HandledCourses>{
  
  Future<List> getData(String id) async{
    final response=await http.get("http://10.0.2.2/pregma/api/getInstructorHandledCourse.php?student_id="+id+" ");                                       
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

      appBar: AppBar(
            //0xffff3266
            backgroundColor: Color(0xff3399fe),
            automaticallyImplyLeading: true, 
            elevation: 0.0,
            title: Text("Handled Courses"),
          ), 


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
     
          return  Padding(
          
            padding: const EdgeInsets.all(16.0),
            
            child: Card(
              color: Colors.white,
              child: Padding(
                
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[

                  Text(
                           list[i]['subject_code'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 24.0
                              ),
                    ),
                    
                    
                    Text("Days: "+' '+
                           list[i]['days'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),
                    
                    Text("Start Time:"+' '+
                           list[i]['time_start'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),
                    Text("End Time:"+' '+
                           list[i]['time_end'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),

                     Text( 
                        'Section:' +' '+  list[i]['section'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),
                  
                    Text("Units: "+' '+
                           list[i]['units'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),
                 
                MaterialButton(
                  child: Text("VIEW MASTERLIST"),
                  color:Color(0xff3399fe),
                  textColor: Colors.white,
                  onPressed: (){
                      Navigator.of(context).push(
                                 MaterialPageRoute(builder: (BuildContext context)=> MasterList(list:list,index:i, student_id:prefix0.student_id, )), 
                      );
                  },
                ),  
                  ],
                ),
              )
            ),


          );  
      }
    );
  }
}