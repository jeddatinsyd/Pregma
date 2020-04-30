import 'package:flutter/material.dart';
import 'CustomShapeClipper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HotelMain extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Total(),
    );
  }
}

class Total extends StatefulWidget{
  String student_id;
  Total({Key key,this.student_id}) : super(key:key);
  
  @override
  _UserProfile createState() => new _UserProfile();
}

class _UserProfile extends State<Total>{ 

  String balance = "balance ";
            
        Future<String> _toProfile(String id) async {

        var response = await http.get(
        Uri.encodeFull(
            "http://10.0.2.2/pregma/api/getTotalBalance.php?student_id="+id+" "),
            headers: {"Accept": "application/json"});
            var data2 = json.decode(response.body);
            setState(() 
            {
              if(data2 != null) {
              
                balance = data2[0]['balance'];
              }
              else{
                balance='balalnce is null';
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
           
            _toProfile(widget.student_id);
          });
        } 

@override
  Widget build(BuildContext context) {
    return Container(
                height: MediaQuery.of(context).size.height/3,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      Expanded(
                        flex: 2,
                        child: Text("Balance"+balance,style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                        ),)),  
                     
                    ],
                )
              );
  }
}
