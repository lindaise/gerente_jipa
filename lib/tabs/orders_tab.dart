import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/orders_bloc.dart';
import 'package:gerente_loja/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _ordersBloc = BlocProvider.of<OrdersBloc>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16), // espaço em cima e em baixo do card
      child: StreamBuilder<List>(  // chama o stream do orders_bloc
        stream: _ordersBloc.outOrders,
        builder: (context, snapshot) {
          if(!snapshot.hasData) // se não encontrar dados mostrar circulo de aguarde
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.teal),
              ),
            );
          else if(snapshot.data.length == 0)
            return Center(
              child: Text("Nenhum pedido encontrado!",
                style: TextStyle(color: Colors.teal),),
            );

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              return OrderTile(snapshot.data[index]);
            }
          );
        }
      ),
    );
  }
}
