import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modelos/transacao.dart';

class ListaTransacoes extends StatelessWidget {
  final List<Transacao> _transacoes;
  ListaTransacoes(this._transacoes);

  Widget build(BuildContext contexto) {
    return Container(
      height: 700,
        child:  _transacoes.isEmpty? 
        Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Text(
                'Nenhuma transação cadastrada.',
                style: Theme.of(contexto).textTheme.headline6
              ),
              SizedBox(height: 30,),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        )
        : ListView.builder(
            itemCount: _transacoes.length,
            itemBuilder: (cntx, indice) {
              final t = _transacoes[indice];
              return Card(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Theme.of(contexto).primaryColor, width: 2)),
                    padding: EdgeInsets.all(10),
                    child: Text('R\$ ' + t.valor.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(contexto).primaryColor,
                        )),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(t.titulo,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(contexto).primaryColor)),
                        ),
                        Container(
                            child: Text(DateFormat('d MMM y').format(t.data),
                                style: TextStyle(color: Colors.grey)))
                      ])
                ],
              ));
            }));
  }
}
