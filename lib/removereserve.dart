import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'subjectmain.dart';
import 'package:akic_pregma/main.dart' as prefix0;
import 'dashboard.dart';
class RemoveReserve extends StatefulWidget {
  List list;
  int index;
  final String student_id;
  
  RemoveReserve({Key key, this.list,this.index,this.student_id}) : super(key:key);

  @override 
  _RemoveReserve createState() => _RemoveReserve();
}

class _RemoveReserve extends State<RemoveReserve> {
  String student_id;
   String username;

    void remove()async{
    var url="http://10.0.2.2/pregma/api/reserveRemove.php";
    http.post(url,body: {
      "offered_subject_id": widget.list[widget.index]['offered_subject_id'].toString(),
        //${widget.list[widget.index]['subject_code']}
      "student_id": username.toString(),
      });
    }

    void deleteduplicate()async{
    var url="http://10.0.2.2/pregma/api/reserveRemove.php";
    http.post(url,body: {
      });
    }



  void confirm(){
    AlertDialog alertDialog=new AlertDialog(
      content: Text("Are your sure?"),  
      actions: <Widget>[
        MaterialButton(
          child:Text("YES"),
          onPressed: (){
              remove();
              deleteduplicate();
              Navigator.of(context).pop(false);
            // Navigator.push(context, MaterialPageRoute(builder: (context){
            //         return SubjectMain(student_id:prefix0.student_id);
            // }));
        //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SubjectMain(student_id:widget.student_id),), (e) => false);
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubjectMain(student_id:widget.student_id),), (e) => false);
       
       //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new SubjectMain(student_id:widget.student_id)));
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => new Dashboard(student_id: widget.student_id, )));
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
  
  Future<String> _toProfile(String id) async {

        var response = await http.get(
        Uri.encodeFull(
            "http://10.0.2.2/pregma/api/getReserveSubject.php?student_id="+id+"  "),
              
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
        }//future

   @override
        void  initState(){
          super.initState();
          setState(() {
             _toProfile(widget.student_id);
          });
  }

  @override 
  Widget build(BuildContext context ){
    return Scaffold(
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
              leading: Icon(Icons.person_add),
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
            MaterialButton(
                  child: Text("Confirm"),
                  color:Color(0xFFFC6A7F),
                  textColor: Colors.white,
                  onPressed: (){
                    confirm();
                  },
            ),    

              ],
            ),
          ),
          

    );
  }
}