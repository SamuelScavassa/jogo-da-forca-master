import 'dart:html';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(JogoForca());

class JogoForca extends StatefulWidget {
  @override
  State<JogoForca> createState() => _JogoForcaState();
}

String imagem = '';
List palavras = ['teclado', 'mouse', 'webcam', 'cpu', 'headset'];
String palavra = '';
String mask = '';
String mask2 = '';
var input_controle = TextEditingController();
String char = '';
int cont = 0;
String vit = '';

void letra(String value) {
  List<String> aux = [];

  if (mask.toUpperCase() == palavra.toUpperCase()) {
    var x = '';
    var z = palavra.toUpperCase();
    imagem = 'images/step01.png';
    var num = Random().nextInt(6);
    palavra = palavras[num];
    for (var element in palavra.characters.toUpperCase()) {
      x = '${x}_';
    }
    mask2 = x;
    vit = 'Parabéns você acertou! a palavra era: $z';
  } else {
    vit = '';
    for (var element in mask.characters) {
      aux.add(element);
    }
    if (palavra.toUpperCase().contains(value.toUpperCase())) {
      var index = palavra.toUpperCase().indexOf(value.toUpperCase());
      aux[index] = value.toUpperCase();
      mask2 = aux.join('');
    } else {
      cont += 1;
      if (cont == 1) {
        imagem = 'images/step02.png';
        mask2 = mask;
      } else {
        if (cont == 2) {
          imagem = 'images/step03.png';
          mask2 = mask;
        } else {
          if (cont == 3) {
            imagem = 'images/step04.png';
            mask2 = mask;
          } else {
            if (cont == 4) {
              imagem = 'images/step05.png';
              mask2 = mask;
            } else {
              if (cont == 5) {
                imagem = 'images/step06.png';
                mask2 = '';
                mask = palavra;
                mask2 = 'FIM DE JOGO';
              } else {
                mask2 = '';
                cont = 0;
                imagem = 'images/step01.png';
                var num = Random().nextInt(6);
                palavra = palavras[num];
                for (var element in palavra.characters.toUpperCase()) {
                  mask2 = '${mask2}_';
                }
              }
            }
          }
        }
      }
    }
  }

  input_controle.text = '';
}

class _JogoForcaState extends State<JogoForca> {
  @override
  void initState() {
    super.initState();
    imagem = 'images/step01.png';
    var num = Random().nextInt(6);
    palavra = palavras[num];
    for (var element in palavra.characters.toUpperCase()) {
      mask = '${mask}_';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo Forca',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(imagem),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsetsDirectional.all(10),
                child: Text(
                  '$mask',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                  width: 10,
                )),
                height: 90,
                width: 70,
                child: TextField(
                  controller: input_controle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    letra(value);
                    setState(() {
                      mask = mask2;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Flexible(
              child: Text(
                '$vit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
