class conversorDataSigaa {
  static conversorDataSigaa instance = new conversorDataSigaa();

  /// Cria dicionário para mapear os números e letras aos dias e horas reais
  var mapaDias = {2: 'SEG', 3: 'TER', 4: 'QUA', 5: 'QUI', 6: 'SEX', 7: 'SAB'};
  var mapaHorarios = {
    'M1': {'inicio': '07:00', 'fim': '08:00'},
    'M2': {'inicio': '08:00', 'fim': '09:00'},
    'M3': {'inicio': '09:00', 'fim': '10:00'},
    'M4': {'inicio': '10:00', 'fim': '11:00'},
    'M5': {'inicio': '11:00', 'fim': '12:00'},
    'T1': {'inicio': '12:00', 'fim': '13:00'},
    'T2': {'inicio': '13:00', 'fim': '14:00'},
    'T3': {'inicio': '14:00', 'fim': '15:00'},
    'T4': {'inicio': '15:00', 'fim': '16:00'},
    'T5': {'inicio': '16:00', 'fim': '17:00'},
    'N1': {'inicio': '17:00', 'fim': '18:00'},
    'N2': {'inicio': '18:00', 'fim': '19:00'},
    'N3': {'inicio': '19:00', 'fim': '20:00'},
    'N4': {'inicio': '20:00', 'fim': '21:00'},
    'N5': {'inicio': '21:00', 'fim': '22:00'}
  };

  /// Padrão regex que reconhece o formato de horário do SIGAA */
  String padraoSigaa = r'([2-7]{1,5})([MTN])([1-7]{1,7})';

  mapeiaHorarios(match) {
    var dia;
    if (match.group(1).length > 1) {
      String d1 =
          mapaDias[int.parse(match.group(1).substring(0, 1))].toString();
      String d2 = mapaDias[int.parse(match
              .group(1)
              .substring(match.group(1).length - 1, match.group(1).length))]
          .toString();
      dia = d1 + " à " + d2;
    } else {
      dia = mapaDias[int.parse(match.group(1))];
    }
    var hora_inicio = mapaHorarios[
        '${match.group(2)}${match.group(3).substring(0, 1)}']!['inicio'];
    var hora_fim = mapaHorarios[
            '${match.group(2)}${match.group(3).substring(match.group(3).length - 1, match.group(3).length)}']![
        'fim'];
    return '${dia} ${hora_inicio}-${hora_fim}';
  }

  /// Função que separa os dias para que toda "palavra" de horário tenha só 1 dígito de dia antes do turno.
  /// ex: 246M12 vira 2M12 4M12 6M12.
  ///
  /// Quando já está devidamente separado, retorna o mesmo texto.
  ///
  /// @param {*} match     O horário completo reconhecido pelo regex
  /// @param {*} g1        O primeiro grupo de captura do regex - no caso, o(s) dígito(s) do dia da semana
  /// @param {*} g2        O segundo grupo de captura do regex - no caso, a letra do turno
  /// @param {*} g3        O terceiro grupo de captura do regex - no caso, o conjunto de dígitos dos horários
  separaDias(match, g1, g2, g3) {
    return [...g1].map((dia) => '${dia}${g2}${g3}').join(' ');
  }

  /// Função que recebe o texto com os horários e o ordena pela ordem dos dias da semana
  /// Ou seja, o primeiro dígito de cada "palavra".
  ///
  /// @param {*} texto     O texto HTML dos horários separados por espaço, que já foi tratado pela separaDias().
  /// @returns   O texto com os horários ordenados separados por espaço.
  ordenaDias(texto) {
    var horario = RegExp(padraoSigaa).allMatches(texto).toList();
    horario
        .sort((a, b) => a.group(1).toString().compareTo(b.group(1).toString()));
    return horario.map((a) => a.group(0)).join(' ');
  }

  converteHorario(String horario) {
    // horario = ordenaDias(horario);
    var listaHorarios = RegExp(padraoSigaa).allMatches(horario).toList();
    String retorno = '';
    listaHorarios.forEach((element) {
      retorno += mapeiaHorarios(element) + " ";
    });
    return retorno;
  }
}
