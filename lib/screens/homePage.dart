import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pgd_generator/screens/pdf_preview_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final pdf = pw.Document();

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text(name.text.trim(), textScaleFactor: 2),
                  ])),
          pw.Header(level: 1, text: 'Email: ${email.text.trim()}'),

          // Write All the paragraph in one line.
          // For clear understanding
          // here there are line breaks.
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit libero volutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus molestie nunc non blandit massa. Bibendum enim facilisis gravida neque. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum."),
          pw.Paragraph(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit libero volutpat Vitae elementum curabitur vitae nunc sed velit. Nibh tellus molestie nunc non blandit massa. Bibendum enim facilisis gravida neque. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam  vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. '),
          pw.Header(level: 1, text: 'This is Header'),
          pw.Paragraph(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Table.fromTextArray(context: context, data: const <List<String>>[
            <String>['Year', 'Sample'],
            <String>['SN0', 'GFG1'],
            <String>['SN1', 'GFG2'],
            <String>['SN2', 'GFG3'],
            <String>['SN3', 'GFG4'],
          ]),
        ];
      },
    ));
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    file.writeAsBytesSync(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PDF Generator",
          textScaleFactor: 1.2,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please Enter Your Name:",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffE8ECF4), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 121, 48, 181), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: const Color(0xffE8ECF4),
                  filled: true,
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Enter Email",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xffE8ECF4), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 121, 48, 181), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: const Color(0xffE8ECF4),
                  filled: true,
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      writeOnPdf();
                      await savePdf();
                    } catch (err) {}

                    Directory documentDirectory =
                        await getApplicationDocumentsDirectory();

                    String documentPath = documentDirectory.path;

                    String fullPath = "$documentPath/example.pdf";
                    print(fullPath);

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfPreviewScreen(
                                  path: fullPath,
                                )));
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStatePropertyAll<Color>(Colors.white),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    child: Text("Generate"),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
