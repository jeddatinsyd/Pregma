import 'dart:convert';
import 'package:flutter/material.dart';
import 'stacked_icons.dart';
import 'dashboard.dart';
import 'dashboard2.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

String student_id='';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.aZ
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/Dashboard2': (BuildContext context) => new Dashboard2(student_id: student_id,),
        '/Dashboard': (BuildContext context) => new Dashboard(student_id: student_id, ),
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response = await http.post("http://10.0.2.2/pregma/api/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });
    //print(response.body);

    var data = json.decode(response.body);

    if (data.length == 0) {
      setState(() {
        msg = "Login failed";
      });
    } else {
      if (data[0]['user_type'] == 'faculty') {
        Navigator.pushReplacementNamed(context, '/Dashboard2');
      } else if (data[0]['user_type'] == 'student') {
        Navigator.pushReplacementNamed(context, '/Dashboard');
      }
        setState(() {
        student_id=data[0]['username']; 
        });
      }
    return data; 
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Color(0xFF18D191))),
          
      body: Container (
        child: SingleChildScrollView(
 
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //new StackedIcons(),
              SizedBox(
                height: 155.0,
                child: Image.asset("assets/pregma.png",fit:BoxFit.contain,),
              ),
             
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: new TextField(
                  controller: user,
                  decoration: new InputDecoration(labelText: 'LOGIN ID'),
                ),
              ),
              new SizedBox(
                height: 15.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: new TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: new InputDecoration(labelText: 'PASSWORD'),
                ),
              ),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0),
                      child: GestureDetector(
                        // onTap: () {
                        //    Navigator.push(context, MaterialPageRoute(
                        //      builder: (context) => Dashboard2(),
                        //   //   builder: (context) => _login(),
                        //    ));
                        // //    _login();
                        // },
                        onTap: () {
                          _login();
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFF18D191),
                              borderRadius: new BorderRadius.circular(10.0)),
                          child: new Text(
                            "Login",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              new Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0),
                    child: new Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      child: new Text(
                        msg,
                        style: new TextStyle(fontSize: 20.0, color: Colors.red),
                      ),
                    ),
                  ))
                ],
              )
            ]),
        ),
      ),
    );
  }
}
