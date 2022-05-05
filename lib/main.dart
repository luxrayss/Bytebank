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
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoNumeroValor =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text('Criando Transferência'),
        ),
        body: Column(
          children:[
            Editor(
              controlador: _controladorCampoNumeroConta,
              dica: '0000',
              rotulo: 'Número da Conta',
            ),
            Editor(
                controlador: _controladorCampoNumeroValor,
                rotulo: 'Valor',
                dica: '0.00',
                icone: Icons.monetization_on),
            ElevatedButton(
              onPressed: () => _criaTransferencia(context),
              child: const Text('Confirmar'),
            ),
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta =
        int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor =
        double.tryParse(_controladorCampoNumeroValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      final snackBar = SnackBar(
        content: Text('$transferenciaCriada'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData?icone;


  //tornando os atributos do editor opcionais
  Editor({required this.controlador, required this.rotulo, required this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Card ficará dentro de uma coluna para poder haver vários cards
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return FormularioTransferencia();
          }));
        },
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

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
