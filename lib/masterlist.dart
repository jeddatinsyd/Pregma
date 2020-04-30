import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MasterList extends StatefulWidget {
  List list;
  int index;
  final String student_id;
  
  MasterList({this.list,this.index,this.student_id});
  @override 
  _MasterList createState() => _MasterList();
}

class _MasterList extends State<MasterList> {
  
  Future<List> getData(String id,String subject_code) async{
    final response=await http.get("http://10.0.2.2/pregma/api/getMasterList.php?student_id="+id+"&subject_code="+subject_code+" ");                                       
   return json.decode(response.body);
  }
   @override
        void  initState(){
          super.initState();
          setState(() {
            getData(widget.student_id,widget.list[widget.index]['subject_code']  );
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
            title: Text("Masterlist Data"),
          ), 
       body:  
          
          FutureBuilder<List>(
          future: getData(widget.student_id,widget.list[widget.index]['subject_code']),
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
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    list[i]['l_name']+','+list[i]['f_name'],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    list[i]['course_name']+' - '+list[i]['major'],
                    style: TextStyle(
                      fontSize: 14.0,
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