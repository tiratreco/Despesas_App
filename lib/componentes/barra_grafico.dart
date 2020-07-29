import 'package:flutter/material.dart';

class BarraGrafico extends StatelessWidget {
  final Map<String, Object> dado_dia;

  BarraGrafico(this.dado_dia);

  @override
  Widget build(BuildContext context) {
    print(dado_dia['porcentagem']);
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          FittedBox(
            child: Text(dado_dia['valor'].toString()),
          ),Container(
            height: 60,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border:Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: dado_dia['porcentagem'],
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                )
              ],
            )
          ),
          Text(dado_dia['dia'])
        ],
      ),
    );
  }
}
