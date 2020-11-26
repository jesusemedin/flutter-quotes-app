
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

import 'package:quotes_app/providers/quote_provider.dart';
import 'package:quotes_app/widgets/items_tarjeta.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final quoteProvider = new QuoteProvider();

  Color colorPrimario = Color.fromRGBO(36, 254, 65, 1.0);
  Color colorSecundario = Color.fromRGBO(40, 60, 134, 1.0);
  String backgroundImage = 'card5';

  @override
  Widget build(BuildContext context) {

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
          newQuote();
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
          image: AssetImage('assets/img/$backgroundImage.jpg'),
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

    return FutureBuilder(
      future: quoteProvider.getQuote(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.hasData) {
          final quote = snapshot.data;
          return ItemsTarjeta(quote: quote);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
  }

  void newQuote(){
    final random = Random();
    setState(() {
    quoteProvider.getQuote();
    colorPrimario = Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
    colorSecundario = Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
    backgroundImage = 'card${random.nextInt(5)}';
    });
  }
}