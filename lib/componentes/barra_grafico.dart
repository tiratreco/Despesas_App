import 'package:flutter/material.dart';

class BarraGrafico extends StatelessWidget {
  final Map<String, Object> dado_dia;
  final double porcentagem;

  BarraGrafico(this.dado_dia, this.porcentagem);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Text(dado_dia['valor'].toString()),
          Container(
            height: 60,
            width: 10,
            child: null,
          ),
          Text(dado_dia['dia'])
        ],
      ),
    );
  }
}
