import 'package:despesas/componentes/barra_grafico.dart';
import 'package:despesas/modelos/transacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'barra_grafico.dart';

class Grafico extends StatelessWidget {
  final List<Transacao> _transacoes_recentes;

  List<Map<String, Object>> get transacoesOrganizadas {
    double total = 0;

    var lista = List.generate(7, (index) {
      final diaSemana = DateTime.now().subtract(Duration(days: index));

      double soma_total = 0;
      for (var i = 0; i < _transacoes_recentes.length; i++) {
        bool mesmo_dia = _transacoes_recentes[i].data.day == diaSemana.day;
        bool mesmo_mes = _transacoes_recentes[i].data.month == diaSemana.month;
        bool mesmo_ano = _transacoes_recentes[i].data.year == diaSemana.year;

        if (mesmo_dia && mesmo_mes && mesmo_ano) {
          soma_total += _transacoes_recentes[i].valor;
          total += _transacoes_recentes[i].valor;
        }
      }

      return {'dia': DateFormat.E().format(diaSemana)[0], 'valor': soma_total};
    }).reversed.toList();
    lista.forEach((element) {
      (total == 0)?
        element['porcentagem'] = 0.0
        : element['porcentagem'] = (element['valor'] as double) / total;
    });
    return lista;
  }

  Grafico(this._transacoes_recentes);

  Widget build(BuildContext contexto) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: transacoesOrganizadas.map((e) {
          return Flexible(
            child: BarraGrafico(e),
            fit: FlexFit.tight
          );
        }).toList(),
      ),
    );
  }
}
