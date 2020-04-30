import 'package:flutter/material.dart';

class EnrolledSubject extends StatefulWidget{

  String student_id;  
  EnrolledSubject({Key key,this.student_id}) : super(key:key);
  
  @override
  _EnrolledSubject createState() => _EnrolledSubject();
} 

class _EnrolledSubject extends State<EnrolledSubject> {
  
  @override 
  Widget build(BuildContext context ){
    return new Container(
        child: new Center(
          child: new Text('Enrolled Subject', style: new TextStyle(fontSize: 25.0,color: Colors.purple),
                        ),
        ),
    );
  }
}