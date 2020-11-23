import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:math';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String phrase = 'Your new quote will be appear here';
  String tag = '';
  String author = 'Welcome';

  Color colorPrimario = Color.fromRGBO(36, 254, 65, 1.0);
  Color colorSecundario = Color.fromRGBO(40, 60, 134, 1.0);

  Future getQuote() async {
    final response = await http.get('http://api.quotable.io/random');
    final quote = json.decode(response.body);

    phrase = quote['content'];
    tag = quote['tags'][0];
    author = quote['author'];
    
    print(phrase);
    print(tag);
    print(author);
  }

  @override
  Widget build(BuildContext context) {

    getQuote();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backgroundApp(),
          _appBar(),
          _tarjeta()
        ],
      ),
      floatingActionButton: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        color: Color.fromRGBO(255, 255, 255, 1.0),
        textColor: Colors.white,
        elevation: 10.0,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
        child: Text('Give me a new Quote', style: TextStyle( color: Colors.black,  fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: 1.8)),
        onPressed: (){
          _newQuote();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _backgroundApp(){

    return AnimatedContainer(
      duration: Duration( seconds: 3 ),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(1.0, 0.0),
          end: FractionalOffset(0.0, 1),
          colors: <Color>[
            colorPrimario,
            colorSecundario,
          ]
        ),
      ),
    );
  }

  Widget _appBar(){
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Your Quote App', style: TextStyle( color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold ),),
            IconButton(
              icon: Icon( Icons.search ),
              color: Colors.white,
              iconSize: 30.0,
              tooltip: 'Search',
              splashColor: Colors.white,
              onPressed: (){
              }
            )
          ],
        ),
      ),
    );
  }

  Widget _tarjeta(){

    final imagenRotada = Center(
      child: Transform.rotate(
        angle: 0,
        child: Image(
          image: AssetImage('assets/img/card4.jpg'),
          // width: 400.0,
          height: 600.0,
          fit: BoxFit.cover,
        ),
      )
    );

    final blur = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container( color: Color.fromRGBO(255, 255, 255, 0.7)),
    );

    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 500.0,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              blurRadius: 35.0,
              spreadRadius: 15.0
            )
          ],
          color: Colors.white
        ),
        child: Stack(
          children: [
            imagenRotada,
            Positioned.fill(child: blur),
            _itemsTarjeta()
          ],
        ),
      ),
    );
  }

  Widget _itemsTarjeta(){

    final categoryFontStyle = TextStyle( color: Color.fromRGBO(40, 60, 134, 1.0),  fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: 1.8,),
          quoteFontStyle = TextStyle( color: Colors.black87,  fontSize: 20, fontWeight: FontWeight.w300, letterSpacing: 1.8),
          authorFontStyle = TextStyle( color: Colors.brown[700],  fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: 1.8);


    return Container(
      padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 25.0, left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon( Icons.format_quote, color: Color.fromRGBO(40, 60, 134, 1.0), size: 40.0,),
              SizedBox( width: 60.0),
              Text(tag.replaceAll('-', ' '), style: categoryFontStyle),
            ]
          ),
          Text(phrase, style: quoteFontStyle, textAlign: TextAlign.center , overflow: TextOverflow.fade,),
          Text('- ' + author + ' -', style: authorFontStyle,)
        ]
      ),
    );
  }

  void _newQuote(){

    final random = Random();

    setState((){
      getQuote();
      colorPrimario = Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
      colorSecundario = Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
    });
  }
}