  convert(int digit) {
    final int number = digit;
    String numberString = '0000000000' + number.toString();
    numberString =
        numberString.substring(number.toString().length, numberString.length);
    var str = '';

    switch ('en-in') {
      case 'en-in':
        List<String> ones = [
          '',
          'uno',
          'dos',
          'tres',
          'cuatro',
          'cinco',
          'seis',
          'siete',
          'ocho',
          'nueve',
          'diez ',
          'once ',
          'doce ',
          'trece ',
          'catorce ',
          'quince ',
          'dieciseis ',
          'diecisiete ',
          'dieciocho ',
          'diecinueve '
        ];
        List<String> onesMiles = [
          '',
          'un ',
          'dos ',
          'tres ',
          'cuatro ',
          'cinco ',
          'seis ',
          'siete ',
          'ocho ',
          'nueve ',
          'diez ',
          'once ',
          'doce ',
          'trece ',
          'catorce ',
          'quince ',
          'dieciseis ',
          'diecisiete ',
          'dieciocho ',
          'diecinueve '
        ];
        List<String> onesMilesPlus = [
          '',
          '',
          'dos',
          'tres',
          'cuatro',
          'cinco',
          'seis',
          'siete',
          'ocho',
          'nueve',
          'diez',
          'once ',
          'doce',
          'trece',
          'catorce',
          'quince',
          'dieciseis',
          'diecisiete',
          'dieciocho',
          'diecinueve'
        ];
        List<String> cienes = [
          '',
          'uno',
          'dos',
          'tres',
          'cuatro',
          'cinco',
          'seis',
          'sete',
          'ocho',
          'nove',
          'diez',
          'once',
          'doce',
          'trece',
          'catorce',
          'quince',
          'dieciseis',
          'diecisiete',
          'dieciocho',
          'diecinueve'
        ];
        List<String> tens = [
          '',
          '',
          'veinte',
          'treinta',
          'cuarenta',
          'cincuenta',
          'sesenta',
          'setenta',
          'ochenta',
          'noventa',
        ];
        List<String> millones = [
          '',
          'un millon',
          'dos millones',
          'tres millones',
          'cuatro millones',
          'cinco millones',
          'siete millones',
          'siete millones',
          'ocho millones',
          'nueve millones',
        ];
        List<String> complementos = [
          '',
          '',
          'veinti',
          'treinta y ',
          'cuarenta y ',
          'cincuenta y ',
          'sesenta y ',
          'setenta y ',
          'ochenta y ',
          'noventa y ',
        ];

        str += (numberString[0]) != '0'
            ? ones[int.parse(numberString[0])] + 'hundred '
            : '';
        //hundreds
        if ((int.parse('${numberString[1]}${numberString[2]}')) < 20 &&
            (int.parse('${numberString[1]}${numberString[2]}')) > 9) {
          str += ones[int.parse('${numberString[1]}${numberString[2]}')] +
              'crore ';
        } else {
          str += (numberString[1]) != '0'
              ? tens[int.parse(numberString[1])] + ' '
              : ''; //tens
          str += (numberString[2]) != '0'
              ? ones[int.parse(numberString[2])] + 'crore '
              : ''; //ones
          str += (numberString[1] != '0') && (numberString[2] == '0')
              ? 'crore '
              : '';
        }
        if ((int.parse('${numberString[3]}${numberString[4]}')) < 20 &&
            (int.parse('${numberString[3]}${numberString[4]}')) > 9) {
          str += millones[int.parse(numberString[3])] + ' ';
          str += (numberString[4]) != '0'
              ? ((numberString[4]) == '1' &&
                      (numberString[5]) == '0' &&
                      (numberString[6]) == '0')
                  ? 'cien mil'
                  : ((numberString[4]) == '1' &&
                          (numberString[5]) == '0' &&
                          (numberString[6]) == '1')
                      ? 'ciento un'
                      : (numberString[4]) == '1'
                          ? 'ciento '
                          : ((numberString[4]) != '0' &&
                                  (numberString[5]) == '0' &&
                                  (numberString[6]) == '0')
                              ? ones[int.parse(numberString[4])] +
                                  'cientos mil '
                              : ones[int.parse(numberString[4])] + 'cientos '
              : '';
          str += (numberString[3] != '0') && (numberString[4] == '0') ? '' : '';
        } else {
          str += (numberString[3]) != '0'
              ? millones[int.parse(numberString[3])] + ' '
              : '';
          str += (numberString[4]) != '0'
              ? ((numberString[4]) == '1' &&
                      (numberString[5]) == '0' &&
                      (numberString[6]) == '0')
                  ? 'cien mil'
                  : ((numberString[4]) == '1' &&
                          (numberString[5]) == '0' &&
                          (numberString[6]) == '1')
                      ? 'ciento'
                      : (numberString[4]) == '1'
                          ? 'ciento '
                          : ((numberString[4]) != '0' &&
                                  (numberString[5]) == '0' &&
                                  (numberString[6]) == '0')
                              ? ones[int.parse(numberString[4])] +
                                  'cientos mil '
                              : ones[int.parse(numberString[4])] + 'cientos '
              : '';
          str += (numberString[3] != '0') && (numberString[4] == '0') ? '' : '';
        }
        if ((int.parse('${numberString[5]}${numberString[6]}')) < 20 && (int.parse('${numberString[5]}${numberString[6]}')) > 9) {
          str += ones[int.parse('${numberString[5]}${numberString[6]}')] + 'mil ';
        } else {
          str += (numberString[5]) != '0' ? complementos[int.parse(numberString[5])] +onesMiles[int.parse(numberString[6])]  : '';
          str += (numberString[6]) != '0' ? (numberString[6]) == '0' ? 'mil ' : (numberString[5]) == '0' ? 
          (numberString[3]) == '0'&&(numberString[4]) == '0'&&(numberString[5]) == '0'? (numberString[6]) != '1'?onesMilesPlus[int.parse(numberString[6])] + ' mil ':onesMilesPlus[int.parse(numberString[6])] + 'mil ':
          
          ' '+onesMiles[int.parse(numberString[6])] + 'mil ':'': '';
          str += (numberString[5] != '0') && (numberString[6] == '0')
              ? 'mil '
              : (numberString[5]) == '0'? '':'mil ';
        }
        str += (numberString[7]) != '0'
            ? ((numberString[7]) == '1' &&
                    (numberString[8]) == '0' &&
                    (numberString[9]) == '0')
                ? 'cien'
                : (numberString[7]) == '1'
                    ? 'ciento '
                    : (numberString[7]) == '5'
                        ? 'quinientos '
                        : cienes[int.parse(numberString[7])] + 'cientos '
            : '';
        if ((int.parse('${numberString[8]}${numberString[9]}')) < 20 &&
            (int.parse('${numberString[8]}${numberString[9]}')) > 9) {
          str += ones[int.parse('${numberString[8]}${numberString[9]}')];
        } else {
          str += (numberString[8]) != '0'
              ? (numberString[9]) == '0'
                  ? tens[int.parse(numberString[8])]
                  : complementos[int.parse(numberString[8])]
              : ''; //tens
          str +=
              (numberString[9]) != '0' ? ones[int.parse(numberString[9])] : '';
        }
        break;

      default:
        str += 'not acceptable format';
    }
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }
