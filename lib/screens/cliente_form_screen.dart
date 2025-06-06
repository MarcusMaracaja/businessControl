import 'package:flutter/material.dart';
import '../models/cliente.dart';
import '../controllers/cliente_controller.dart';

class ClienteFormScreen extends StatefulWidget {
  final int idEmpresa;
  final Cliente? cliente; // <- Agora aceita cliente opcional para edição

  const ClienteFormScreen({
    super.key,
    required this.idEmpresa,
    this.cliente,
  });

  @override
  State<ClienteFormScreen> createState() => _ClienteFormScreenState();
}

class _ClienteFormScreenState extends State<ClienteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.cliente != null) {
      _nomeController.text = widget.cliente!.nome;
      _telefoneController.text = widget.cliente!.telefone;
      _cepController.text = widget.cliente!.cep;
      _enderecoController.text = widget.cliente!.endereco;
    }
  }

  Future<void> salvar() async {
    if (_formKey.currentState!.validate()) {
      final cliente = Cliente(
        id: widget.cliente?.id, // <- Só preenche se for edição
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        cep: _cepController.text,
        endereco: _enderecoController.text,
        idEmpresa: widget.idEmpresa,
      );

      final controller = ClienteController();
      if (widget.cliente == null) {
        await controller.salvarCliente(cliente); // novo
      } else {
        await controller.atualizarCliente(cliente); // editar
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cliente == null ? 'Novo Cliente' : 'Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: _cepController,
                decoration: const InputDecoration(labelText: 'CEP'),
              ),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
