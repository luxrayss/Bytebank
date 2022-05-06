import 'package:flutter/material.dart';

//Quando for usado o RaisedButton, substituir por ElevatedButton
//Corrigir transferências que não aparecem na tela principal
//Corrigir bug das activities
//criar classes separadas

//Iniciando um MaterialApp
void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {

  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ).copyWith(
          secondary: Colors.purpleAccent[700],
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          primary: Colors.purpleAccent[700],
        )),
      ),
      home: ListaTransferencias(),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //Ao ser chamada, a classe retornará uma nova transferencia com numero da conta e valor, depois add na lista
    return FormularioTransferenciaState();

  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia>{

  //Vars
  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoNumeroValor =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //cor da app bar
         // backgroundColor: Colors.deepPurpleAccent,
          //título da appbar
          title: Text('Criando Transferência'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                //Editando o controlador do número da conta
                controlador: _controladorCampoNumeroConta,
                //alterando a dica do controlador
                dica: '0000',
                //rótulo
                rotulo: 'Número da Conta',
              ),
              Editor(
                  controlador: _controladorCampoNumeroValor,
                  //rótulo do controlador do valor
                  rotulo: 'Valor',
                  //valor
                  dica: '0.00',
                  //icone
                  icone: Icons.monetization_on),
              ElevatedButton(
                //chamando a função de criar nova transferencia
                onPressed: () => _criaTransferencia(context),
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoNumeroValor.text);

    //verificando se o número não é nulo para ser criado uma nova transferencia
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criado a transferencia');
      //criando uma snackbar
      final snackBar = SnackBar(
        content: Text('$transferenciaCriada'),
      );
      //exibindo a snackbar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //finalizando a tela de transferencia
      Navigator.pop(context, transferenciaCriada);
    }
  }

}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  //tornando o icone opcional
  Editor(
      {required this.controlador,
      required this.rotulo,
      required this.dica,
      this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //espaçamento entre os campos de texto
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        //tamanho da fonte
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          //verificando se o ícone tem valor nulo e exibindo
          icon: icone != null ? Icon(icone) : null,
          //exibindo campo de texto com rótulo e dica
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = <Transferencia>[];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaTransferenciasState();
  }

}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.deepPurpleAccent,
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        //Lista de transferências
        //Verificando quantos itens tem na lista
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future =
          //redirecionando para a página de nova transferencia ao clicar no botão
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          //exibindo a lista
          future.then((transferenciaRecebida) {
            debugPrint('Chegou no then');
            debugPrint('$transferenciaRecebida');
            //evitando erros quando o valor for nulo/ao tentar retornar para a página de transferencias
            if (transferenciaRecebida != null) {
              setState(() {
                //adicionando na lista
                widget._transferencias.add(transferenciaRecebida);
              });
            }
          });
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
    //envolvendo os itens da lista de transferência em um card
    return Card(
      child: ListTile(
        //icone do card
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
