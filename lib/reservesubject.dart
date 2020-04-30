import 'package:akic_pregma/removereserve.dart';
import 'package:flutter/material.dart';
import 'CustomShapeClipper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:akic_pregma/main.dart' as prefix0;

class ReserveSubject extends StatefulWidget{

  String student_id;  
  ReserveSubject({Key key,this.student_id}) : super(key:key);
  
  @override
  _ReserveSubject createState() => _ReserveSubject();
} 

class _ReserveSubject extends State<ReserveSubject>{
  
  Future<List> getData(String id) async{
    final response=await http.get("http://10.0.2.2/pregma/api/getReserveSubject.php?student_id="+id+" ");                                       
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
     
          return  Padding(
          
            padding: const EdgeInsets.all(16.0),
            
            child: Card(
              color: Colors.white70,
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
                    Text(
                           list[i]['description'],
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

                    Text("Day: "+' '+
                           list[i]['days'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),
                    
                    Text("Time:"+' '+
                           list[i]['time_start']+' - '+ list[i]['time_end'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),
                  


                     Text( "Instructor: "+' '
                           +list[i]['name'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),

                     Text( 
                         'Section:' +' '+ list[i]['section'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),
                  
                MaterialButton(
                  child: Text("REMOVE"),
                  color:Color(0xFFFC6A7F),
                  textColor: Colors.white,
                  onPressed: (){
                      Navigator.of(context).push(
                                 MaterialPageRoute(builder: (BuildContext context)=> RemoveReserve(list:list,index:i, student_id:prefix0.student_id , )), 
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