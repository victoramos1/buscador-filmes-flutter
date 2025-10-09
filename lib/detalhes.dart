import 'package:flutter/material.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: (){},
            child: Text("Buscar",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
      body: Container(
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
                  height: 500,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(17),
                      bottom: Radius.circular(17)
                    ),
                    child: Image.asset(
                      "imagens/sem-imagem.jpg",
                      height: 494,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15), child: Text("Batman: O Cavaleiro das Trevas", textAlign: TextAlign.justify, style: TextStyle(color: Colors.white))),
              Padding(padding: EdgeInsets.only(top: 10), child: Text("Nota TMDB: 8.524 / 10", textAlign: TextAlign.justify, style: TextStyle(color: Colors.white))),
              Padding(padding: EdgeInsets.only(top: 10), child: Text("Bilheteria: U\$ 185.000.000", textAlign: TextAlign.justify, style: TextStyle(color: Colors.white))),
              Padding(padding: EdgeInsets.only(top: 10), child: Text("Custo: U\$ 1.004.558.444", textAlign: TextAlign.justify, style: TextStyle(color: Colors.white))),
              Padding(padding: EdgeInsets.only(top: 10, right: 15, left: 15), child: Text("Sinopse: Após dois anos desde o surgimento do Batman, os criminosos de Gotham City têm muito o que temer. Com a ajuda do tenente James Gordon e do promotor público Harvey Dent, Batman luta contra o crime organizado. Acuados com o combate, os chefes do crime aceitam a proposta feita pelo Coringa e o contratam para combater o Homem-Morcego.", textAlign: TextAlign.justify, style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}

