import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modelos/transacao.dart';

class ListaTransacoes extends StatelessWidget {
  final List<Transacao> _transacoes;
  final void Function(String) _removerElemento;
  ListaTransacoes(this._transacoes, this._removerElemento);

  Widget build(BuildContext contexto) {
    return Container(
        height: 700,
        child: _transacoes.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Text('Nenhuma transação cadastrada.',
                        style: Theme.of(contexto).textTheme.headline6),
                    SizedBox(
                      height: 30,
                    ),
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
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '\$${t.valor}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '${t.titulo}',
                        style: Theme.of(contexto).textTheme.headline6,
                      ),
                      subtitle: Text(DateFormat('d MMM y').format(t.data)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(contexto).errorColor,
                        onPressed: () => _removerElemento(t.id)
                        ,
                      ),
                    ),
                  );
                }));
  }
}
