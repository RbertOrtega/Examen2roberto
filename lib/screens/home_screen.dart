import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/ticket_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tickets Aéreos')),
      body: StreamBuilder(
        stream: ticketProvider.getTickets(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar tickets'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final ticket = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(ticket['numeroVuelo']),
                subtitle: Text('${ticket['origen']} - ${ticket['destino']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => ticketProvider.deleteTicket(doc.id),
                ),
                onTap: () => context.go('/edit/${doc.id}'),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
