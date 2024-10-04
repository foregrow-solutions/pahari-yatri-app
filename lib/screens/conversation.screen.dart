import 'dart:io';
import 'dart:typed_data';
import '../services/gpt.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../common/app.config.dart';
import '../services/pixabay.service.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  String place = '';
  String quote = '';
  String body = '';
  ScrollController outerController = ScrollController();
  ScrollController innerController = ScrollController();
  GPTService? gptService;
  List<String> landscapes = [];

  void _scrollToBottom() {
    outerController.animateTo(
      outerController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    gptService = GPTService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    Future.delayed(Duration.zero, () {
      fetchPixabayImages(widget.query).then((value) => setState(() {
        landscapes = value;
      }));
    });
    Future.delayed(Duration.zero, () {
      setState(() {
        place = gptService?.findPlace(
            prompt: widget.query,
            listen: (text) {
              setState(() {
                place += text;
              });
            }) ??
            '';
      });
      setState(() {
        quote = gptService?.generateAttractiveQuote(
            prompt: widget.query,
            listen: (text) {
              setState(() {
                quote += text;
              });
            }) ??
            '';
      });
      setState(() {
        body = gptService?.preparePlan(
            prompt: widget.query,
            place: place,
            listen: (text) {
              setState(() {
                body += text;
              });
            }) ??
            '...';
      });
    });
  }

  @override
  void dispose() {
    outerController.dispose();
    innerController.dispose();
    super.dispose();
  }

  /*Future<void> _saveAsPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context ctx) {
          return pw.Container(
            child: pw.Column(
              children: [
                // Your widget content here
                pw.Container(
                  width: MediaQuery.of(context).size.width,
                  height: 240,
                  // ... rest of the code ...
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(16.0),
                  color: PdfColors.white,
                  child: pw.Column(
                    children: [
                      // ... rest of the code ...
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final outputFile = File('${outputDir.path}/conversation.pdf');
    await outputFile.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF saved to Downloads'),
      ),
    );
  }*/

  /*Future<void> _sharePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (ctx) {
          return pw.Container(
            child: pw.Column(
              children: [
                // Your widget content here
                pw.Container(
                  width: MediaQuery.of(context).size.width,
                  height: 240,
                  // ... rest of the code ...
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(16.0),
                  color: PdfColors.white,
                  child: pw.Column(
                    children: [
                      // ... rest of the code ...
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    *//*final outputDir = await getApplicationDocumentsDirectory();
    final outputFile = File('${outputDir.path}/conversation.pdf');
    await outputFile.writeAsBytes(await pdf.save());*//*

    Uint8List finalFile = await pdf.save();

    // Share the PDF file
    await Share.shareXFiles([XFile.fromData(finalFile)]);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('"${widget.query}"'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 10,
        actions: [
          /*IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAsPdf,
          ),*/
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Coming Soon'),
                    content: const Text('This feature is coming soon!'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        controller: outerController,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 240,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background2.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  kPrimaryColorOpacity,
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ListView.builder(
                    controller: innerController,
                    reverse: true,
                    // Set reverse to true for autoscrolling
                    scrollDirection: Axis.horizontal,
                    itemCount: landscapes.length >= 5 ? 5 : landscapes.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle tap on image
                        },
                        child: Image.network(
                          landscapes[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        place.replaceAll("\"", "").replaceAll(":", "").replaceAll(".", "").trim(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        quote.replaceAll("\"", "").replaceAll(":", "").trim(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: FutureBuilder(
              future: replaceImageTags(body),
              builder: (ctx, snap) {
                if (snap.data != null) {
                  return MarkdownBody(
                    selectable: true,
                    data: snap.data!,
                  );
                }
                return MarkdownBody(
                  selectable: true,
                  data: body,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
