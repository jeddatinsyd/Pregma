import 'package:akic_pregma/subjectmain.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'offeredsubject.dart';
import 'dashboard.dart';
import 'package:akic_pregma/main.dart' as prefix0;
import 'subjectmain.dart';
class Details extends StatefulWidget {
  List list;
  int index;
  final String student_id;
  
  Details({this.list,this.index,this.student_id});
  @override 
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
    String studentID="";
  String username="";
  String username2="";
  String time_start = "";
  String days="",
        time_end = "";

             String msg = '';

  void reserve()async{
   var url="http://10.0.2.2/pregma/api/reserveSubject.php";
    http.post(url,body: {
      "offered_subject_id": widget.list[widget.index]['offered_subject_id'].toString(),
        //${widget.list[widget.index]['subject_code']}
      "student_id": username.toString(),
    });
  }
  void deleteDuplicate()async{
    var url="http://10.0.2.2/pregma/api/removeDuplicate.php";
    http.post(url,body: {
      "offered_subject_id": widget.list[widget.index]['offered_subject_id'].toString(),
        //${widget.list[widget.index]['subject_code']}
      "student_id": username.toString(),
    });
  }

  void validateReserve() async{

  if(time_start==widget.list[widget.index]['time_start'].toString() && days== widget.list[widget.index]['days'].toString() && username2==username)
  {
    conflict();
  }
  else{
     confirm();
    }
  }
  void conflict(){
    AlertDialog alertDialog=new AlertDialog(
      content: Text("Conflict Schedule"),  
      actions: <Widget>[
        MaterialButton(
          child:Text("Okay"),
          onPressed: (){
            Navigator.of(context).pop(false);
          },
        )
      ],
    );
    showDialog(context: context,child: alertDialog);
  }

  void confirm(){
    AlertDialog alertDialog=new AlertDialog(
      content: Text("Are your sure?"),  
      actions: <Widget>[
        MaterialButton(
          child:Text("YES"),
          onPressed: (){
              reserve();
            //  deleteDuplicate();

              Navigator.of(context).pop(false);
             
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder:(BuildContext context )=>offeredSubject(student_id:widget.student_id)
              //     //builder:(BuildContext context )=>Subject(student_id:this.student_id)
              //   ),
              // );  
           // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => offeredSubject(student_id:widget.student_id),), (e) => false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>  SubjectMain(student_id: prefix0.student_id, )));
              //  SubjectMain(student_id:prefix0.student_id);
          },
        ),
        MaterialButton(
          child: Text("NO"),
          onPressed: (){
                Navigator.of(context).pop(false);
          },
        ),
      ],
    );
    showDialog(context: context,child: alertDialog);
  }
  
  Future<String> _getReserve(String id) async {

        var response = await http.get(
        Uri.encodeFull(
            "http://10.0.2.2/pregma/api/getReserveSubject.php?student_id="+id+" "),
              
            headers: {"Accept": "application/json"});
         
            var data2 = json.decode(response.body);
            setState(() 
            {
              if(data2 != null) {
                days = data2[0]['days'];
                time_start = data2[0]['time_start'];
                time_end = data2[0]['time_end'];
                username2 = data2[0]['student_id'];
              }
              else{
                    //  username='';
              }
            }
            ); 
            print(data2);
            return data2;
            //return data2;
        }

        Future<String> _toProfile(String id) async {

        var response = await http.get(
        Uri.encodeFull(
            "http://10.0.2.2/pregma/api/getStudentInfo.php?student_id="+id+" "),
              
            headers: {"Accept": "application/json"});
         
            var data2 = json.decode(response.body);
            setState(() 
            {
              if(data2 != null) {
                username = data2[0]['student_id'];
              }
              else{
                username='';
              }
            }
            ); 
            print(data2);
            return data2;
            //return data2;
        }

   @override
        void  initState(){
          super.initState();
          setState(() {
          //  student_id= widget.student_id;
          _toProfile(widget.student_id);
          _getReserve(widget.student_id);  
             
          });
  }

  @override 
  Widget build(BuildContext context ){
    return new Scaffold(
          appBar: AppBar(
            title: Text("${widget.list[widget.index]['subject_code']}"),
               backgroundColor: Color(0xFFFC6A7F),
          ),

          body: Container(
            child: Column(
              children: <Widget>[

                
            ListTile(
              leading: Icon(Icons.book),
              title: Text("Description"),
              subtitle: Text(widget.list[widget.index]['description'],style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),


             ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text("Units"),
              subtitle: Text(widget.list[widget.index]['units'],style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),

             ListTile(
              leading: Icon(Icons.access_time),
              title: Text("Time Start"),
              subtitle: Text(widget.list[widget.index]['time_start'],style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),

             ListTile(
              leading: Icon(Icons.av_timer),
              title: Text("Time End"),
              subtitle: Text(widget.list[widget.index]['time_end'],style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("Instructor"),
              subtitle: Text(widget.list[widget.index]['name'],style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),

            ListTile(
              leading: Icon(Icons.room),
              title: Text("Section"),
              subtitle: Text(widget.list[widget.index]['section'],style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),
            ListTile(
              leading: Icon(Icons.room),
              title: Text("Room"),
              subtitle: Text(widget.list[widget.index]['room'],style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),
            MaterialButton(
                  child: Text("Confirm"),
                  color:Color(0xFFFC6A7F),
                  textColor: Colors.white,
                  onPressed: (){
                   // confirm();
                   validateReserve();
                  },
            ),    

              ],
            ),
          ),
          

    );
  }
}