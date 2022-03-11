import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //text result
  String resultado = "";

  //imagem do app padrão (app`s image)
  String _imagepadrao = "assets/images/padrao.png";

  //imagens para uso (images for uses)
  List<String> images  = [
    "assets/images/papel.png", //pedra
    "assets/images/pedra.png", // tesoura
    "assets/images/tesoura.png" // papel
  ];

  void _play(int valor){
    //método que faz a jogada randômica (method that makes randomly)
    resultado = "";

    setState(() {
      int randomic = Random().nextInt(3);
      String choice = images[randomic];
      _imagepadrao = choice; // altera a imagem (change image)
      print("${randomic == valor}");
      if(randomic == 1 && valor == 1){
        resultado = "empate!";
      }
      if(randomic == 0 && valor == 1){
        resultado = "Você perdeu!";
      }if(randomic == 2 && valor == 1){
        resultado = "Você ganhou!";
      }

      if(randomic == 0 && valor == 2){
        resultado = "Você venceu!";
      }else if(randomic == 1 && valor == 2){
        resultado = "Você perdeu!";
      }else if(randomic ==2 && valor == 2){
        resultado = "Empate!";
      }

      if(randomic == 0 && valor == 3){
        resultado = "Empate!";
      }else if(randomic == 1 && valor == 3){
        resultado = "Você venceu!";
      }else if(randomic == 2 && valor == 3){
        resultado = "Você perdeu!";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //barra superior (top bar)
      appBar: AppBar(
        centerTitle: true,
        title: Text("Joken Po"),
        backgroundColor: Colors.indigo,
      ),

      //conteúdo (content)
      body: Center(


        child: Container(
          padding: EdgeInsets.only(top:32, bottom: 16),

          child: Column(


            children: <Widget>[

              Text(
                "Escolha do App",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),

              Image.asset(_imagepadrao),
              Text("\n $resultado \n",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),),

              Text(
                "Escolha uma opção abaixo:",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              Text("\n"),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //classe que detecta movimentos (detect click)
                  GestureDetector(
                    onTap: (){
                      _play(1);
                    },
                    child:Image.asset("assets/images/pedra.png", height: 95,),
                  ),

                  GestureDetector(
                    onTap: (){
                      _play(2);
                    },
                    child: Image.asset("assets/images/tesoura.png", height: 95),
                  ),

                  GestureDetector(
                    onTap: (){
                      _play(3);
                    },
                    child: Image.asset("assets/images/papel.png", height: 95),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}