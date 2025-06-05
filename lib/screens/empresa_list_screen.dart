import 'package:flutter/material.dart';
import '../models/empresa.dart';
import '../controllers/empresa_controller.dart';
import 'empresa_form_screen.dart';

class EmpresaListScreen extends StatefulWidget {
  const EmpresaListScreen({super.key});
  @override
  State<EmpresaListScreen> createState() => _EmpresaListScreenState();
}

class _EmpresaListScreenState extends State<EmpresaListScreen> {
  final _controller = EmpresaController();
  List<Empresa> _empresas = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _empresas = await _controller.listarPorUsuario(/*id do usuário*/);
    setState(() {});
  }

  Future<void> _openForm([Empresa? e]) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => EmpresaFormScreen(empresa: e)),
    );
    if (result == true) _load();
  }

  void _confirmDelete(Empresa e) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Excluir ${e.nome}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Não')),
          TextButton(
            onPressed: () async {
              await _controller.excluir(e.id!);
              Navigator.pop(context);
              _load();
            },
            child: const Text('Sim', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    appBar: AppBar(title: const Text('Empresas')),
    body: ListView.builder(
      itemCount: _empresas.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(_empresas[i].nome),
        subtitle: Text(_empresas[i].cnpj),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _confirmDelete(_empresas[i]),
        ),
        onTap: () => _openForm(_empresas[i]),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _openForm(),
      child: const Icon(Icons.add),
    ),
  );
}
