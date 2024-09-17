import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';

class TicketFormScreen extends StatefulWidget {
  final String? id;

  const TicketFormScreen({Key? key, this.id}) : super(key: key);

  @override
  _TicketFormScreenState createState() => _TicketFormScreenState();
}

class _TicketFormScreenState extends State<TicketFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ticket = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'Agregar Ticket' : 'Editar Ticket'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Número de Vuelo'),
              onSaved: (value) => _ticket['numeroVuelo'] = value,
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Aerolínea'),
              onSaved: (value) => _ticket['aerolinea'] = value,
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Origen'),
              onSaved: (value) => _ticket['origen'] = value,
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Destino'),
              onSaved: (value) => _ticket['destino'] = value,
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (widget.id == null) {
                    await ticketProvider.addTicket(_ticket);
                  } else {
                    await ticketProvider.updateTicket(widget.id!, _ticket);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(widget.id == null ? 'Agregar' : 'Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
