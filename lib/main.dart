import 'package:flutter/material.dart';

//Quando for usado o RaisedButton, substituir por ElevatedButton

//Iniciando um MaterialApp
void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //corpo do app
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Criando Transferência'),),
        body: Column(
          children: [
            TextField(
              style: TextStyle(
                fontSize: 16.0
              ),
              decoration: InputDecoration(
                labelText: 'Número da Conta',
                hintText: '0000',
              ),
            ),
          ],
        ));
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Card ficará dentro de uma coluna para poder haver vários cards
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: <Widget>[
          //Chamando o método do valor e conta
          ItemTransferencia(Transferencia(100.00, 1000)),
          ItemTransferencia(Transferencia(200.00, 2000)),
          ItemTransferencia(Transferencia(300.00, 3000)),
          ItemTransferencia(Transferencia(400.00, 4000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        //icone do botão
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {

  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  //construtor
  Transferencia(this.valor, this.numeroConta);
}
