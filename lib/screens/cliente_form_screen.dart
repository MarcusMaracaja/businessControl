import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../controllers/cliente_controller.dart';
import '../utils/correios_api.dart';

class ClienteFormScreen extends StatefulWidget {
  final Cliente? cliente;
  const ClienteFormScreen({super.key, this.cliente});

  @override
  State<ClienteFormScreen> createState() => _ClienteFormScreenState();
}

class _ClienteFormScreenState extends State<ClienteFormScreen> {
  final _form = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _tel = TextEditingController();
  final _cep = TextEditingController();
  final _end = TextEditingController();
  final _ctrl = ClienteController();

  @override
  void initState() {
    super.initState();
    if (widget.cliente != null) {
      _nome.text = widget.cliente!.nome;
      _tel.text = widget.cliente!.telefone;
      _cep.text = widget.cliente!.cep;
      _end.text = widget.cliente!.endereco ?? '';
    }
  }

  void _buscarCep() async {
    final e = await CorreiosAPI.consultarEndereco(_cep.text);
    setState(() => _end.text = e);
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: Text(widget.cliente == null ? 'Novo Cliente' : 'Editar Cliente')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(controller: _nome, decoration: const InputDecoration(labelText: 'Nome')),
            TextFormField(controller: _tel, decoration: const InputDecoration(labelText: 'Telefone')),
            TextFormField(controller: _cep, decoration: const InputDecoration(labelText: 'CEP'), keyboardType: TextInputType.number, onEditingComplete: _buscarCep),
            TextFormField(controller: _end, decoration: const InputDecoration(labelText: 'Endereço')),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () async {
                if (!_form.currentState!.validate()) return;
                final c = Cliente(
                  id: widget.cliente?.id,
                  nome: _nome.text,
                  telefone: _tel.text,
                  cep: _cep.text,
                  endereco: _end.text,
                  idEmpresa: /*id da empresa*/,
                );
                if (widget.cliente == null) await _ctrl.inserir(c);
                else await _ctrl.atualizar(c);
                Navigator.pop(ctx, true);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
