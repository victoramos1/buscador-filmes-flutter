import 'package:flutter/material.dart';
import 'detalhes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultadoBusca extends StatefulWidget {
  final String campoDigitado;
  const ResultadoBusca(this.campoDigitado, {super.key});

  @override
  State<ResultadoBusca> createState() => _ResultadoBuscaState();
}

class _ResultadoBuscaState extends State<ResultadoBusca> {

  Map<String, dynamic> filmes = {};
  //Coloque a sua Api Key gerada abaixo (entre as aspas)
  String apiKey = "";

  Future<Map<String, dynamic>> dadosRecebidos() async {
    var retorno = await http.get(Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=${apiKey}&query=${widget.campoDigitado}&language=pt-BR"));
    filmes = jsonDecode(retorno.body);
    return filmes;
  }

  void buscarFilme(){
    dadosRecebidos().then((dados){
      setState(() {
        filmes = dados;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    buscarFilme();
  }

  void verDetalhes(id){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Detalhes(id)));
  }

  TextEditingController controller = TextEditingController();

  void fazerBusca (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultadoBusca(controller.text)));
  }

  @override
  Widget build(BuildContext context) {

    if (filmes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Buscador de filmes"),
          backgroundColor: Color(0xff14181c),
        ),
        body: Container(
          color: Color(0xff14181c),
          child: Center(
            child: CircularProgressIndicator(),
          )
        )
      );
    }

    if (filmes['results'].isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Buscador de filmes"),
          backgroundColor: Color(0xff14181c),
        ),
        body: Container(
          color: Color(0xff14181c),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(16),
                        backgroundColor: Color(0xff00c030),
                        foregroundColor: Colors.white,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 350),
                    child: Text(
                      "Nenhum resultado encontrado para '${widget.campoDigitado}'.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset("imagens/icone.png"),
        ),
        title: Text("Buscador de filmes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
        backgroundColor: Color(0xff14181c),
        actions: [
          Container(
            width: 100,
            height: 45,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Digite",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)
                  )
                )
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(25, 45),
              backgroundColor: Color(0xff00c030),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                )
              )
            ),
            onPressed: fazerBusca,
            child: Text("Buscar",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: filmes["results"].length,
        itemBuilder: (context, index){

        final filme = filmes["results"][index];
        final urlImagem = filme["poster_path"];
        final titulo = filme["title"];
        final id = filme["id"];

      Widget imagemFilme() {
        if (urlImagem != null && urlImagem.isNotEmpty && urlImagem != "null") {
          return Image.network("https://image.tmdb.org/t/p/w400/$urlImagem",
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover
          );
        } else{
          return Image.asset("imagens/sem-imagem.jpg",
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover);
          }
        }

          return Container(
            color: Color(0xff14181c),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 3
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff14181c)
                      ),
                      width: 300,
                      height: 550,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(17),
                            ),
                            child: imagemFilme()
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(padding: EdgeInsets.only(top: 15),
                              child: Text(titulo,
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ),
                          ElevatedButton(
                            onPressed: (){
                              verDetalhes(id);
                            },
                            child: Text("Ver detalhes",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(30, 35),
                              backgroundColor: Color(0xff00c030),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            )
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
