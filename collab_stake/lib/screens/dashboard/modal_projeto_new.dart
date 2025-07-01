import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collab_stake/repositories/projeto_repository.dart';
import 'package:intl/intl.dart';
import 'package:collab_stake/bloc/projetoBloc/projeto_bloc.dart';

class ModalProjetoNew extends StatefulWidget {
  @override
  State<ModalProjetoNew> createState() => _ModalProjetoNewState();
}

class _ModalProjetoNewState extends State<ModalProjetoNew> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController areaAtuacaoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController dataInicioController = TextEditingController();
  final TextEditingController dataFinalController = TextEditingController();

  bool _isLoading = false;
  final int _descricaoMaxLength = 1500;

  Future<void> _criarProjeto() async {
    final String nome = nomeController.text;
    final String endereco = enderecoController.text;
    final String areaAtuacao = areaAtuacaoController.text;
    final String descricao = descricaoController.text;
    final String dataInicio = dataInicioController.text;
    final String dataFinal = dataFinalController.text;

    if (nome.isEmpty ||
        endereco.isEmpty ||
        areaAtuacao.isEmpty ||
        descricao.isEmpty ||
        dataInicio.isEmpty ||
        dataFinal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    context.read<ProjetoBloc>().add(
      CriouProjetosEvent(
        nome: nome,
        endereco: endereco,
        areaAtuacao: areaAtuacao,
        descricao: descricao,
        dataInicio: dataInicio,
        dataFinal: dataFinal,
      ),
    );

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pop(); 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Projeto criado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return AlertDialog(
      title: Text(
        'Criar Novo Projeto',
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome do Projeto',
                labelStyle: TextStyle(color: primaryColor),
                floatingLabelStyle: TextStyle(color: primaryColor),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(
                labelText: 'Endereço',
                labelStyle: TextStyle(color: primaryColor),
                floatingLabelStyle: TextStyle(color: primaryColor),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: areaAtuacaoController,
              decoration: InputDecoration(
                labelText: 'Área de Atuação',
                labelStyle: TextStyle(color: primaryColor),
                floatingLabelStyle: TextStyle(color: primaryColor),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descricaoController,
              maxLength: _descricaoMaxLength,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(color: primaryColor),
                floatingLabelStyle: TextStyle(color: primaryColor),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                counterText:
                    '${descricaoController.text.length} / $_descricaoMaxLength',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            selectDate(
              context: context,
              onDateRangeSelected: (inicio, fim) {
                dataInicioController.text = inicio;
                dataFinalController.text = fim;
                setState(() {});
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
          ),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _criarProjeto,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: onPrimary,
          ),
          child: _isLoading
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
                  ),
                )
              : const Text('Salvar'),
        ),
      ],
    );
  }
}

Widget selectDate({
  required BuildContext context,
  void Function(String dataInicio, String dataFim)? onDateRangeSelected,
  DateTime? dataInicio,
  DateTime? dataFim,
}) {
  final primaryColor = Theme.of(context).primaryColor;
  final secondaryColor = Theme.of(context).colorScheme.secondary;
  final onPrimary = Theme.of(context).colorScheme.onPrimary;
  final screenWidth = MediaQuery.of(context).size.width;

  return InkWell(
    onTap: () async {
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        helpText: 'Inicio e fim do intervalo',
        builder: (BuildContext context, Widget? child) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 600),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: primaryColor,
                    secondary: secondaryColor,
                    onPrimary: onPrimary,
                  ),
                  appBarTheme: AppBarTheme(
                    backgroundColor: primaryColor,
                    foregroundColor: onPrimary,
                  ),
                  dialogBackgroundColor: primaryColor.withOpacity(0.05),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                    ),
                  ),
                ),
                child: child!,
              ),
            ),
          );
        },
      );

      if (picked != null) {
        var dataInicio =
            DateTime(picked.start.year, picked.start.month, picked.start.day);
        var dataFim =
            DateTime(picked.end.year, picked.end.month, picked.end.day);
        String inicioString = DateFormat('yyyy-MM-dd').format(dataInicio);
        String fimString = DateFormat('yyyy-MM-dd').format(dataFim);
        // Salva as datas nos controllers via callback
        if (onDateRangeSelected != null) {
          onDateRangeSelected(inicioString, fimString);
        }
      }
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 600 ? 12 : 8,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 4),
            child: Icon(
              Icons.calendar_today,
              size: screenWidth > 600 ? 22 : 16,
              color: primaryColor,
            ),
          ),
          Text(
            "Data",
            style: TextStyle(
              color: primaryColor,
              fontSize: screenWidth > 600 ? 16 : 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
