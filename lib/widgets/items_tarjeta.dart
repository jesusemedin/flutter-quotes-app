import 'package:flutter/material.dart';

class ItemsTarjeta extends StatefulWidget {

  final quote;

  ItemsTarjeta({ @required this.quote});

  @override
  _ItemsTarjetaState createState() => _ItemsTarjetaState();
}

class _ItemsTarjetaState extends State<ItemsTarjeta> {



  @override
  Widget build(BuildContext context) {
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
              Text(widget.quote.tag, style: categoryFontStyle),
            ]
          ),
          Text(widget.quote.phrase, style: quoteFontStyle, textAlign: TextAlign.center , overflow: TextOverflow.fade,),
          Text('- ' + widget.quote.author + ' -', style: authorFontStyle,)
        ]
      ),
    );
  }
}