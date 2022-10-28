import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget{
  const TransactionItem({
    Key key,
    @required this.transactions, 
    @required this.deleteTx,

  }) : super(key: key);


final List<Transaction> transactions;
final Function deleteTx;

@override
  Widget build(BuildContext context) {
    return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? ElevatedButton.icon(
                            label: Text('Delete'),
                            icon: Icon(Icons.delete),
                            // textColor: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transactions[index].id),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transactions[index].id),
                          ),
                  ),
                );
  }
}
  }
};