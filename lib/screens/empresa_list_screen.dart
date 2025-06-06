import 'package:flutter/material.dart';
import '../models/empresa.dart';
import '../controllers/empresa_controller.dart';
import 'empresa_form_screen.dart';
import 'cliente_list_screen.dart'; // <--- IMPORTAÇÃO ADICIONADA

class EmpresaListScreen extends StatefulWidget {
  const EmpresaListScreen({super.key});

  @override
  State<EmpresaListScreen> createState() => _EmpresaListScreenState();
}

class _EmpresaListScreenState extends State<EmpresaListScreen> {
  final _controller = EmpresaController();
  List<Empresa> _empresas = [];

  final int _idUsuario = 1; // <-- Substitua com o ID real do usuário logado

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _empresas = await _controller.listarPorUsuario(_idUsuario);
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
        content: const Text('Esta ação não pode ser desfeita.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              await _controller.excluirEmpresa(e.id!);
              if (context.mounted) Navigator.pop(context);
              _load();
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _abrirClientes(Empresa empresa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClienteListScreen(idEmpresa: empresa.id!),
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
        trailing: Wrap(
          spacing: 12,
          children: [
            IconButton(
              icon: const Icon(Icons.people),
              tooltip: 'Ver Clientes',
              onPressed: () => _abrirClientes(_empresas[i]),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Excluir Empresa',
              onPressed: () => _confirmDelete(_empresas[i]),
            ),
          ],
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
