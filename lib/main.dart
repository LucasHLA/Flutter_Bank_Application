import 'package:flutter/material.dart';

//Lucas Henrique

void main() {
  runApp(_myAppState());
}

class _myAppState extends StatelessWidget {
  const _myAppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const PrimeiraTela(title: 'Tansações Bancárias'),
    );
  }
}

class PrimeiraTela extends StatefulWidget {
  const PrimeiraTela({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PrimeiraTela> createState() => _PrimeiraTelaReal();
}

class _PrimeiraTelaReal extends State<PrimeiraTela> {
  List<String> _Hist = ['Transações Recentes:'];
  TextStyle style = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  TextEditingController valor = TextEditingController();
  double saldo = 100;
  double hist_Dep = 0;
  double hist_Saq = 0;

  double CalculaDeposito() {
    var valor_deposito = double.parse(valor.text);
    return valor_deposito;
  }

  void SaldoAtualizaDeposito() {
    setState(() {
      var valor_deposito = double.parse(valor.text);
      saldo = saldo + valor_deposito;
    });
  }

  void HistoricoDep() {
    setState(() {
      var valor_deposito = double.parse(valor.text);
      hist_Dep = valor_deposito;
    });
  }

  void HistoricoSaq() {
    setState(() {
      var valor_saque = double.parse(valor.text);
      hist_Saq = valor_saque;
    });
  }

  double calculaSaque() {
    var valor_Saque = double.parse(valor.text);
    return valor_Saque;
  }

  void saldoAtualizaSaque() {
    setState(() {
      var valor_deposito = double.parse(valor.text);
      saldo = saldo - valor_deposito;
    });
  }

  @override
  Widget build(BuildContext context) {
    final valorField = TextField(
      controller: valor,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Valor da transação",
          border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
    );

    final depositoButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.zero,
      color: Color.fromARGB(255, 1, 21, 199),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TeladeDeposito(CalculaDeposito(), saldo)));
          SaldoAtualizaDeposito();
          HistoricoDep();
          setState(() {
            _Hist.add('Depósito: + R\$ $hist_Dep');
          });
        },
        child: Text("Depósito",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final saqueButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.zero,
      color: Color.fromARGB(255, 1, 21, 199),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TeladeSaque(calculaSaque(), saldo)));
          saldoAtualizaSaque();
          HistoricoSaq();
          setState(() {
            _Hist.add('Saque: - R\$ $hist_Saq');
          });
        },
        child: Text("Saque",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        body: Center(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Transação Financeira',
                style: TextStyle(fontSize: 32, color: Colors.black),
              ),
              SizedBox(height: 15.0),
              Text(
                'Saldo atual:',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              Text(
                'R\$ $saldo',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              SizedBox(height: 45.0),
              valorField,
              SizedBox(
                height: 15.0,
              ),
              depositoButon,
              SizedBox(
                height: 15.0,
              ),
              saqueButon,
              SizedBox(
                height: 15.0,
              ),
              Column(
                  children: _Hist.map((element) => Card(
                        child: Column(
                          children: <Widget>[Text(element)],
                        ),
                      )).toList()),
            ],
          ),
        ),
      ),
    ));
  }
}

class TeladeDeposito extends StatelessWidget {
  final double _deposito;
  final double _saldo;
  TeladeDeposito(this._deposito, this._saldo);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Depósito"),
        backgroundColor: Color.fromARGB(255, 1, 21, 199),
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Depósito realizado com sucesso!',
            style: TextStyle(fontSize: 32, color: Colors.black),
          ),
          Text(
            'Valor do Depósito:',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          Text(
            'R\$ $_deposito',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          Text(
            'Saldo atual:',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          Text(
            'R\$ $_saldo',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Color.fromARGB(255, 1, 21, 199),
            child: Text(
              'Voltar para a tela inicial',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}

class TeladeSaque extends StatelessWidget {
  final double _saque;
  final double _saldo;
  TeladeSaque(this._saque, this._saldo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de Saque"),
        backgroundColor: Color.fromARGB(255, 1, 21, 199),
      ),
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'Saque realizado com sucesso!',
            style: TextStyle(fontSize: 32, color: Colors.black),
          ),
          Text(
            'Valor do Saque:',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          Text(
            'R\$ $_saque',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          Text(
            'Saldo atual:',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          Text(
            'R\$ $_saldo',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Color.fromARGB(255, 1, 21, 199),
            child: Text(
              'Voltar para a tela inicial',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
