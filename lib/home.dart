import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as internet;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  String _result = '';
  
  TextEditingController _controller = TextEditingController();

  _buscaCep({var cep}) async{
 
    String url = 'http://viacep.com.br/ws/${cep}/json/';

    internet.Response resp;
    resp = await internet.get(url);
    
    Map<String, dynamic> finalResp = json.decode(resp.body);

    setState(() {
      _result = 'Cep: ${finalResp['cep']??''}\nEndereço: ${finalResp['logradouro']??''}\nBairro: ${finalResp['bairro']??''}\nLocal: ${finalResp['localidade']??''}\n';
    });
    print('statusCode:' + resp.statusCode.toString());
    print('resposta:' + resp.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca cep'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(' BUSCA CEP',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
          Padding(padding: EdgeInsets.only(bottom: 30),),
          Container(
            width: 300,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3, color: Colors.blue)
            ),
            child: Text(_result),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10),),
          TextField(
            controller:_controller ,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CEP'),
            maxLength: 8,
          ),
          RaisedButton(child: Text('Click'),
          onPressed: (){
            _buscaCep(cep: _controller.text??'04886060');
          },)
        ],),
      ),
    );
  }
}