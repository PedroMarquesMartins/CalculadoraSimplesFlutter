import 'package:flutter/material.dart';

void main(){
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(home: Scaffold(
        appBar: AppBar(title:
        Center(
          child:Text("Calculadora"),
        ),
          toolbarHeight: kToolbarHeight,  //wtf kkk
        ),
        body: Calculadora(),
      ),
    );
  }
}

class Calculadora extends StatefulWidget{
  @override
  Calculo createState() => Calculo();
}

class Calculo extends State<Calculadora>{

  //iniciando as variaaveis
  String saida = "";
  double resultadoAtual = 0;
  String operador = "";
  bool novaOperacao = true;

  void operacao(String novoOperador){
    if (saida.isNotEmpty) {
      double numAtual = double.parse(saida);
      if (operador.isEmpty){
        resultadoAtual = numAtual;
      } else {
        resultadoAtual = realizarOperacao(resultadoAtual, numAtual, operador);
      }

      setState((){
        operador = novoOperador;
        saida = resultadoAtual.toString();
        novaOperacao = true;
      });
    }
  }

  void igual(){
    if (operador.isNotEmpty && saida.isNotEmpty){
      double numAtual =double.parse(saida);
      setState((){
        resultadoAtual = realizarOperacao(resultadoAtual, numAtual, operador);
        saida =resultadoAtual.toString();
        operador= "";
        novaOperacao =true;
      });
    }
  }

  void apagar(){
    setState((){
      saida = "";
      resultadoAtual = 0;
      operador = "";
      novaOperacao = true;
    });
  }

  double realizarOperacao(double primeiro, double segundo, String operador){

    switch (operador){

      case "+":
        return primeiro+segundo;

      case "-":
        return primeiro-segundo;

      case "X":
        return primeiro*segundo;

      case "/":
        if (segundo!= 0) {
          return primeiro/segundo;
        } else {
          return primeiro;
        }

      default:
        return segundo;
    }
  }

  void pressionarNumero(String numero){
    setState((){
      if (novaOperacao){
        saida= numero;
        novaOperacao =false;
      } else {saida+= numero;}
    });
  }

  Widget botao(String text, Function onPressed){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Column(children:<Widget>[Expanded(
          child: Container(alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(saida, style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),

      Expanded(  //tive que apelar nessa
        flex: 3,
        child:Column(
          children:[
            Row(
              children:[
                botao("7", () => pressionarNumero("7")),
                botao("8", () => pressionarNumero("8")),
                botao("9", () => pressionarNumero("9")),
                botao("/", () => operacao("/")),
              ],
            ),SizedBox(height: 60.0),
            Row(
              children: [
                botao("4", () => pressionarNumero("4")),
                botao("5", () => pressionarNumero("5")),
                botao("6", () => pressionarNumero("6")),
                botao("X", () => operacao("X")),
              ],
            ),SizedBox(height: 60.0),
            Row(
              children: [
                botao("1", () => pressionarNumero("1")),
                botao("2", () => pressionarNumero("2")),
                botao("3", () => pressionarNumero("3")),
                botao("-", () => operacao("-")),
              ],
            ),SizedBox(height: 60.0),
            Row(
              children: [
                botao("0", () => pressionarNumero("0")),
                botao("C", apagar),
                botao("=", igual),
                botao("+", () => operacao("+")),
              ],
            ),SizedBox(height: 60.0),
          ],
        ),
      ),
    ],
    );
  }
}