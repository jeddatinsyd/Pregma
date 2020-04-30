import 'package:akic_pregma/main.dart' as prefix0;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details.dart';
import 'subjectmain.dart';

class OfferedSubjectClass extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: offeredSubject(),
    );
  }
}

class offeredSubject extends StatefulWidget{

  String student_id;  
  offeredSubject({Key key,this.student_id}) : super(key:key);
  
  @override
  _offeredSubject createState() => _offeredSubject();
} 

offeredSubject std = new offeredSubject();

class _offeredSubject extends State<offeredSubject>{

  String student_id;

  Future<List> getData(String id) async{
    final response=await http.get("http://10.0.2.2/pregma/api/getOfferedSubject.php?student_id="+id+" ");
    return json.decode(response.body);
  }

   @override
        void  initState(){
          super.initState();
          setState(() {
            student_id= widget.student_id;
            getData(widget.student_id);
          });
  }

  @override
  Widget build(BuildContext context){
    return  Scaffold(
          appBar: AppBar(
            //0xffff3266
            backgroundColor: Color(0xFFFC6A7F),
            automaticallyImplyLeading: true, 
            elevation: 0.0,
            title: Text("Offered Subject"),
            actions: <Widget>[
              GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SubjectMain(student_id:prefix0.student_id);
                }));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 16.0),
                child: Icon(Icons.subject),
              ),
              )
            ],
          ), 
          body:
         
          FutureBuilder<List>(
          future: getData(student_id),

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
  TimeOfDay t;
  @override
  Widget build(BuildContext context){
    return  ListView.builder(
      
      itemCount: list==null?0:list.length,
      itemBuilder: (ctx,i){
        
        var postItem = list[i];

          var now = new DateTime.now();
  //var formatter = new DateFormat('jm');
  //String formatted = formatter.format(now);


         return  Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[
                    
                  Text(
                           list[i]['subject_code'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 28.0
                              ),
                    ),
                    Text(
                           list[i]['description'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 20.0
                              ),
                    ),
                   Text('Day:'+' '+
                           list[i]['days'].toString(),
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 18.0
                              ),
                    ),
					Text('Room:'+' '+
                           list[i]['room'].toString(),
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 18.0
                              ),
                    ),
					Text('Section:'+' '+
                           list[i]['section'].toString(),
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 18.0
                              ),
                    ),
                    Text('Time:'+' '+
                           list[i]['time_start']+' - '+  list[i]['time_end'],
                              style: TextStyle(
                                color:Colors.black,
                                fontSize: 18.0
                              ),
                    ),
                MaterialButton(
                  child: Text("Reserve"),
                  color:Color(0xFFFC6A7F),
                  textColor: Colors.white,
                  onPressed: (){
                      Navigator.of(context).push(
                                 MaterialPageRoute(builder: (BuildContext context)=> Details(list:list,index:i, student_id:prefix0.student_id , )), 
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