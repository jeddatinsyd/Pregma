import 'package:flutter/material.dart';
import 'CustomShapeClipper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class UserProfile2 extends StatefulWidget{
  String student_id;
  UserProfile2({Key key,this.student_id}) : super(key:key);
  
  @override
  _UserProfile2 createState() => new _UserProfile2();
}

class _UserProfile2 extends State<UserProfile2>{ 

  Color firstColor = Color(0xFFF47D15);
  Color secondColor = Color(0xFFEF772C);
  
      String f_name = "f_name ",
            l_name = "l_name ",
            gender = "gender ",
            civil_status = "civil_status ",
            birthdate = "birthdate ",
            current_address = "current_address ",
            home_address = "home_address ",
            contact_no = "contact_no ",
            course_name = "course_name ",
            department_name = "department ";
      Future<String> _toProfile(String id) async {

        var response = await http.get(
        Uri.encodeFull(
            "http://10.0.2.2/pregma/api/getInstructorInfo.php?student_id="+id+" "),
              
            headers: {"Accept": "application/json"});
         
            var data2 = json.decode(response.body);
            setState(() 
            {
             
              if(data2 != null) {
                f_name = data2[0]['f_name'];
                l_name = data2[0]['l_name'];
                gender = data2[0]['gender'];
                civil_status = data2[0]['civil_status'];
                birthdate = data2[0]['birthdate'];
                current_address = data2[0]['address'];
                //home_address = data2[0]['home_address'];
                contact_no = data2[0]['contact_no'];
                //course_name = data2[0]['course_name'];
                department_name = data2[0]['department_name'];
              }
              else{
                f_name='FNAME_NULL';
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
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
            backgroundColor: Color(0xfff57c00),
            automaticallyImplyLeading: true, 
            elevation: 0.0,
            title: Text("Profile"),
          ),
      body: 
      Column(
        children: <Widget>[


          ListTile(
              leading: Icon(Icons.verified_user),
              title: Text("Name"),
              subtitle: Text(f_name+' '+l_name,style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),
            
                
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Department"),
              subtitle: Text(department_name,style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),


             ListTile(
              leading: Icon(Icons.person),
              title: Text("Gender"),
              subtitle: Text(gender,style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),

            ListTile(
              leading: Icon(Icons.person_pin),
              title: Text("Civil Status"),
              subtitle: Text(civil_status,style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text("Birthdate"),
              subtitle: Text(birthdate,style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),

             ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact"),
              subtitle: Text(contact_no,style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),

             ListTile(
              leading: Icon(Icons.home),
              title: Text("Address"),
              subtitle: Text(current_address,style:TextStyle(
                          fontSize: 20.0,color: Colors.black
                    ),  ),
            ),
        ],
      ),
    );
  }
}
