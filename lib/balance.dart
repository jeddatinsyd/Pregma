import 'package:flutter/material.dart';
import 'CustomShapeClipper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'balance_total.dart';

class HotelMain extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Balance(),
    );
  }
}

class Balance extends StatefulWidget{
  String student_id;
  Balance({Key key,this.student_id}) : super(key:key);
  
  @override
  _Balance createState() => new _Balance();
}

class _Balance extends State<Balance>{ 
 String balance = "balance ";

    Future<List> getData(String id) async{
      final response=await http.get("http://10.0.2.2/pregma/api/getStudentBalance.php?student_id="+id+"");                                       
      return json.decode(response.body);
    }

    Future<String> _toProfile(String id) async {

        var response = await http.get(
        Uri.encodeFull(
            "http://10.0.2.2/pregma/api/getTotalBalance.php?student_id="+id+" "),
            headers: {"Accept": "application/json"});
            var data2 = json.decode(response.body);
            setState(() 
            {
              if(data2 != null) {
                balance = data2[0]['total'];
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
            getData(widget.student_id );
           _toProfile(widget.student_id);
          });
        } 
  @override 
  Widget build(BuildContext context ){  
    return new Scaffold(
      appBar: AppBar(
            backgroundColor: Color(0xff3399fe),
            automaticallyImplyLeading: true, 
            elevation: 0.0,
            title: Text("Balance"),
          ), 
       body:        

      CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [

                  Container(
                    height: 500,
                    child:FutureBuilder<List>(
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
                  ),
                  SizedBox(height: 20,),
                  Row(
                                     children: <Widget>[
                                       Expanded(
                                         flex: 1,
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: <Widget>[
                                             Row(
                                               children: <Widget>[

                                                 Center(
                                                   child: Padding(
                                                     padding: const EdgeInsets.all(8.0),
                                                     child: Text("    Total Balance : "+' '+balance+' php' ,style: TextStyle(fontSize: 20,),),
                                                   ),
                                                 )
                                                  
                                               ],
                                              ),
                                            
                                           ],
                                         ),
                                       ),
                                      
                                      
                                     ],
                                   )
                ]
              ),
            )
          ],
          ),
      
    );
  }
}

class Items extends StatelessWidget {
  List list;
  Items({this.list});
  String student_id='';
  @override
  Widget build(BuildContext context){
    return  ListView.builder(      
      itemCount: list==null?0:list.length,
      itemBuilder: (ctx,i){
        var postItem = list[i];
      //  Total(student_id:list[i]['student_id']);
       return Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
  

                  Text(
                    list[i]['year']+' - '+list[i]['trimester']+' Semester',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Billing Amount: ' +' '+
                    list[i]['billing_amount'],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  Text('Status: ' +' '+
                    list[i]['status'],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  
                  Text('Balance: ' +' '+
                    list[i]['balance'],
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



