import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  
  final DocumentSnapshot order;
  
  OrderTile(this.order);

  final states = [
    //"", "Em preparação", "Em transporte", "Aguardando Entrega", "Entregue"
    "", "Em Análise", "Analisado", "Encerrado"
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4), // espaço entre os card
      child: Card(
        child: ExpansionTile( // ^ botão que expande para baixo
          key: Key(order.documentID),
          initiallyExpanded: order.data["status"] != 3,
          title: Text(
            "#${order.documentID.substring(order.documentID.length - 7, order.documentID.length)} - "
                "${states[order.data["status"]]}", // mostra os ultimos 7 digitos do id do pedido
            style: TextStyle(color: order.data["status"] != 3 ? Colors.grey[850] : Colors.green), // muda a cor do status
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(order),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order.data["products"].map<Widget>((p){
                      return ListTile(
                        title: Text(p["product"]["title"] + " --> " + p["it-works"]),
                        subtitle: Text(p["category"] + "/" + p["pid"]),
                        trailing: Text(
                          p["quantity"].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, //distribui os espaços por igual entre os botoes
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Firestore.instance.collection("users").document(order["clientId"])
                            .collection("orders").document(order.documentID).delete(); // deleta a referencia em meus pedidos do Usuario
                          order.reference.delete(); // deleta do pedido
                        },
                        textColor: Colors.red,
                        child: Text("Excluir"),
                      ),
                      FlatButton(
                        onPressed: order.data["status"] > 1 ? (){
                          order.reference.updateData({"status": order.data["status"] - 1});
                        } : null,
                        textColor: Colors.grey[850],
                        child: Text("Regredir"),
                      ),
                      FlatButton(
                        onPressed: order.data["status"] < 3 ? (){
                          order.reference.updateData({"status": order.data["status"] + 1});
                        } : null,
                        textColor: Colors.green,
                        child: Text("Avançar"),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
