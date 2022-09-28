import 'dart:io';
import 'package:app_artistica/components/button.dart';
import 'package:app_artistica/database/client_model.dart';
import 'package:app_artistica/database/invoice_model.dart';
import 'package:app_artistica/provider/app_state.dart';
import 'package:app_artistica/screens/result_screen/generate_document_invoice.dart';
import 'package:app_artistica/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class SuccessScreen extends StatefulWidget {
  final InvoicesModel invoice;
  final ClientsModel client;
  const SuccessScreen({Key? key, required this.invoice, required this.client})
      : super(key: key);
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool sharebtn = false;
  String? fullPaths;
  bool sendShare = false;
  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          floatingActionButton: sharebtn == true
              ? FloatingActionButton.extended(
                  heroTag: "btn2",
                  backgroundColor:
                      ThemeProvider.themeOf(context).data.primaryColorLight,
                  onPressed: () async {
                    Share.shareFiles([fullPaths!], text: 'app_artistica');
                  },
                  label: const Text(
                    'Enviar Factura PDF' ,
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.picture_as_pdf_outlined,
                    color: Colors.white,
                  ),
                )
              : null,
          body: Container(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: const AssetImage('assets/images/success_1.png'),
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Transacción Completada",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // ignore: deprecated_member_use
                        color: ThemeProvider.themeOf(context).data.accentColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonComponent(
                      text: 'Seguir vendiendo',
                      onPressed: () {
                        final appState = Provider.of<AppState>(context, listen: false);
                        // setState( () => appState.updateSelectedIndexScreenId = 0);
                        return Navigator.pushReplacementNamed(context, 'navigator');
                      },
                    )
                  ],
                ),
              )),
        ));
  }

  Future<void> doSomeAsyncStuff() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    fullPaths = "$documentPath/${widget.client.numberDocument}-${widget.invoice.date}.pdf";
    File myFile = File(fullPaths!);
    
    myFile.writeAsBytesSync( await writeOnPdf(context, widget.invoice, widget.client,await authService.readCredentialNit()).save());
    setState(() => sharebtn = true);
    if (widget.client.email != '') await sendMail(context, myFile);
    setState(() => widget.invoice.fileInvoice = fullPaths);
  }

  sendMail(BuildContext context, fullPaths) async {
    String _username = 'app_artistica@eerpbo.com';
    String _password = '(=9)xS8N+V]u';

    final smtpServer = SmtpServer('mail.eerpbo.com',
        username: _username,
        password: _password,
        ignoreBadCertificate: false,
        ssl: false,
        allowInsecure: true);
    String sendmail = widget.client.email!;
    String konu = 'factura';
    final message = Message()
      ..from = Address(_username)
      ..recipients.add(sendmail)
      ..subject = konu
      ..attachments.add(FileAttachment(fullPaths, contentType: 'text/pdf'));
    try {
      await send(message, smtpServer);
      // ignore: empty_catches
    } on MailerException {}
  }
  
  Future<bool> _onBackPressed() async {
    Navigator.pushReplacementNamed(context, 'navigator');
    return true;
  }
}
