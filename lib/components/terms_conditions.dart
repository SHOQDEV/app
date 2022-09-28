import 'package:flutter/material.dart';

class WidgetTermConditions extends StatelessWidget {
  const WidgetTermConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Divider(),
      const Text('POLÍTICA DE PRIVACIDAD PARA LA APLICACIÓN app_artistica',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text('1. Política de seguridad',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text(
        'Para su seguridad no responda correos electrónicos solicitando datos o claves de acceso, ENTERPRISE BOLIVIA. No tiene como política solicitar a sus clientes información confidencial a través del correo o cualquier otro medio.',
        textAlign: TextAlign.justify,
      ),
      const Divider(),
      const Text('2. Alcance y consentimiento',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text(
        'Usted acepta esta política de privacidad al utilizar la aplicación y servicios relacionados. Esta política de privacidad tiene como finalidad regular el uso de la aplicación app_artistica por parte de nuestros usuarios. Podemos modificar esta política de privacidad en cualquier momento mediante la publicación de una versión actualizada.',
        textAlign: TextAlign.justify,
      ),
      const Divider(),
      const Text(
          'Nuestra  política  de  privacidad incluye  las condiciones  de  uso para app_artistica. La utilización  de  estas  implica  su  aceptación  y  sin  reservas  a  todas  y  cada  una  de  las disposiciones  incluidas en  estas.  En  caso  de  no  aceptar  a  dichas  disposiciones usted  no  debe utilizar app_artistica.',
          textAlign: TextAlign.justify),
      const Divider(),
      const Text('3. Sus derechos de privacidad',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text(
          'Esta política de privacidad describe sus derechos de privacidad con respecto a la recopilación, el uso, el almacenamiento, la distribución y la protección de su información personal.',
          textAlign: TextAlign.justify),
      const Divider(),
      const Text(
          '4. Registro de información de usuario y uso de la Aplicación app_artistica',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text(
          'Recopilamos los siguientes tipos de información personal con el fin de proporcionarle el uso de la aplicación app_artistica y poder personalizar y mejorar su experiencia.',
          textAlign: TextAlign.justify),
      const Divider(),
      const Text(
          'Información que recopilamos automáticamente: Al utilizar la aplicación app_artistica, recopilamos la información que nos envía su teléfono móvil. La información que se nos envía incluye dirección IP del dispositivo, identificación del dispositivo o identificador único.',
          textAlign: TextAlign.justify),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('A) '),
          Expanded(
              child: Text(
                  'Personal, la  aplicación  obtiene  la  información  que  el cliente  proporciona  cuando  se  descarga  y se registra. Para  utilizar  los servicios de app_artistica o acceder  a  determinados contenidos,  deberá  proporcionar  previamente  ciertos  datos  de  carácter  personal,  que  solo serán utilizados para el propósito que fueron recopilados. Cuando se registre con EERPBO (Enterprise Bolivia) y utilice la aplicación app_artistica, de manera obligatoria deberá proporcionar su NIT, nombre de usuario de la Oficina Virtual y Contraseña de la Oficina Virtual.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('B) '),
          Expanded(
              child: Text(
                  'La  información  relacionada  con la transacción, por ejemplo, cuando usted realiza ventas por un bien o servicio.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('C) '),
          Expanded(
              child: Text(
            'La información que usted proporciona cuando se comunica con los servidores de EERPBO (Enterprise Bolivia).',
            textAlign: TextAlign.justify,
          )),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('D) '),
          Expanded(
              child: Text(
                  'La información de tarjetas de crédito/débito es decir el Número de tarjeta y solo el número será registrado para la facturación y uso de la aplicación son datos que son almacenados en el teléfono móvil y son de propiedad del usuario de la aplicación móvil app_artistica.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      const Text('5. Protección de datos '),
      const Divider(),
      const Text(
          'Cómo principio de confidencialidad, app_artistica no comparte ni revela la información obtenida, excepto cuando haya sido solicitada y autorizada por el cliente. La información relacionada al usuario y contraseña es de entera responsabilidad del cliente.',
          textAlign: TextAlign.justify),
      const Divider(),
      const Text('6. Conservación de información'),
      const Divider(),
      const Text(
          'Los datos generados por las transacciones realizadas por cada usuario de acuerdo a lo que establece la norma serán resguardados durante 8 años.',
          textAlign: TextAlign.justify),
      const Divider(),
      const Text('7. Actualización de Servicios'),
      const Divider(),
      const Text(
          'EERPBO realizará la actualización y revisión constante de los productos y/o servicios que se exhiben en esta aplicación. La actualización será realizada previa notificación a los clientes.',
          textAlign: TextAlign.justify),
      const Divider(),
      const Text('8. Uso de la aplicación '),
      const Divider(),
      const Text(
          'EERPBO no tiene control alguno sobre la venta de sus productos o prestación de sus servicios. EERPBO no será responsable, en forma directa o indirecta, por ningún daño o perdida causados por el uso no adecuado de la aplicación.EERPBO no será responsable de ningún daño directo, indirecto, incidental, especial, emergente o punitivo, incluyendo, aunque no en forma taxativa, ningún daño por el lucro cesante, uso de datos u otro tipo de pérdidas intangibles, que fuesen consecuencia de la utilización del servicio por parte suya.',
          textAlign: TextAlign.justify),
      const Divider(),
      const Text('9. Garantía del Cliente con el Proveedor',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text('El cliente declara y garantiza a EERPBO:'),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('A) '),
          Expanded(
              child: Text(
                  'Que tiene plenos poderes y facultades, así como también capacidad legal para celebrar Contratos y cumplir las obligaciones derivadas de los mismos, y que si se está registrando en representación en representación de una empresa o de otra entidad, que tiene la facultad de obligar a su mandante.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('B) '),
          Expanded(
              child: Text(
                  'Que le brindará información completa y precisa a EERPBO, incluyendo aunque no en forma taxativa, sus recomendaciones o requerimientos. Sin embargo, EERPBO se reserva el derecho de verificar y constatar su capacidad legal para celebrar contratos y adquirir obligaciones; si en dicha verificación se constata que usted no cuenta con la capacidad señalada, EERPBO podrá tomar las medidas legales que considere pertinentes.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      const Text('10. Usos Prohibidos',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text(
          'El cliente está obligado a no realizar cualquiera de los siguientes actos:',
          textAlign: TextAlign.justify),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('A) '),
          Expanded(
              child: Text('Suplantar la identidad de alguna persona.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('B) '),
          Expanded(
              child: Text(
                  'Violar alguna ley departamental o nacional a través del servicio mismo de la aplicación.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('C) '),
          Expanded(
              child: Text(
                  'Causar molestias o perturbar a terceros a través del, o en el Servicio',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('D) ', style: TextStyle(color: Colors.black87)),
          Expanded(
              child: Text(
                  'Recopilar o almacenar datos de terceros o acerca de ellos.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('E) '),
          Expanded(
              child: Text(
                  'Utilizar algún aparato, software o rutina para interferir en el funcionamiento adecuado de la aplicación.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('F) '),
          Expanded(
              child: Text(
                  'Utilizar la aplicación de alguna forma que no sea según lo expresamente autorizado',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('G) '),
          Expanded(
              child: Text(
            'Reproducir, duplicar copiar, vender, revender o explotar, con o sin algún fin comercial, alguna parte de la aplicación.',
            textAlign: TextAlign.justify,
          )),
        ],
      ),
      const Divider(),
      const Text('11. Derechos de Autor y Restricciones',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text(
          'EERPBO tiene todos los derechos de propiedad intelectual registrados ante el SENAPI sobre la aplicación ofertada. Por lo que el cliente NO deberá alquilar, vender, ceder, prestar, distribuir, transmitir o transferir de algún otro modo, ninguno de los contenidos de la aplicación app_artistica.',
          textAlign: TextAlign.justify),
      const Divider(),
      const Text('12. Actualización Políticas de Privacidad',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      const Text(
          'EERPBO (Enterprise Bolivia) se reserva el derecho a modificar, total o parcialmente esta política de privacidad. Se aconseja que consulte esta Política de Privacidad periódicamente para cualquier cambio, ya que  el  uso  continuado  será  considerado  como  la  aprobación  de  todos  los  cambios.',
          textAlign: TextAlign.justify),
      const SizedBox(
        height: 10,
      ),
      const Text('13. Recomendaciones',
          style: TextStyle(fontWeight: FontWeight.bold)),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('A) '),
          Expanded(
              child: Text(
                  'Cambiar frecuentemente la contraseña que maneje con el servicio de app_artistica.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('B) '),
          Expanded(
              child: Text('No permitas que otros vean tu contraseña.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('C) '),
          Expanded(
              child: Text('No utilizar la misma contraseña.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('D) '),
          Expanded(
              child: Text(
                  'No compartas, divulgues o muestres ninguno de los siguientes datos:',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(' - '),
          Expanded(
              child: Text('Usuario de acceso a app_artistica.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(' - '),
          Expanded(
              child: Text('Clave de acceso a app_artistica.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('E) '),
          Expanded(
              child: Text(
                  'Utiliza una contraseña compleja difícil de adivinar pero que la puedas recordar.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('F) '),
          Expanded(
              child: Text(
                  'No utilices datos obvios para crear tu contraseña como: fechas de cumpleaños, direcciones, nombres de parientes, etc.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('G) '),
          Expanded(
              child: Text(
                  'No anotes tu contraseña en lugares inseguros o accesibles te recomendamos que la memorices.',
                  textAlign: TextAlign.justify)),
        ],
      ),
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('H) '),
          Expanded(
              child: Text(
                  'Si notas algo raro o sospechoso en la aplicación no hagas operaciones y ponte en contacto con ENTERPRISE BOLIVIA.',
                  textAlign: TextAlign.justify)),
        ],
      ),
    ]);
  }
}
