import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Languagetranslator extends StatefulWidget {
  const Languagetranslator({super.key});

  @override
  State<Languagetranslator> createState() => _LanguagetranslatorState();
}

class _LanguagetranslatorState extends State<Languagetranslator> {
  var languages = ['Somali', 'English', 'Swahili','Arabic'];
  var originalLanguage = 'from';
  var destinationLanguage = 'to';
  var output = '';
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    if (src == '---' || dest == '---') {
      setState(() {
        output = 'Fail to translate';
      });
      return;
    }

    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Somali') {
      return 'so';
    } else if (language == 'Swahili') {
      return 'sw'; // FIXED lowercase
    }
    else if (language == 'Arabic') {
      return 'ar';
    }
    return '---';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        title: const Text("Language Translator App",
        style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    dropdownColor: const Color(0xff10223d),
                    value: originalLanguage == 'from' ? null : originalLanguage,
                    hint: Text(originalLanguage, style:  TextStyle(color: Colors.white)),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem,
                          style: TextStyle(
                              color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        originalLanguage = newValue!;
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Icon(Icons.arrow_right_alt_outlined, color: Colors.white, size: 40),
                  const SizedBox(width: 40),
                  DropdownButton<String>(
                    dropdownColor: const Color(0xff10223d),
                    value: destinationLanguage == 'to' ? null : destinationLanguage,
                    hint: Text(destinationLanguage, style: const TextStyle(color: Colors.white)),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem,
                        style: TextStyle(color: Colors.white),),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        destinationLanguage = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: languageController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Please enter your text...',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2b3c5a),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    translate(
                      getLanguageCode(originalLanguage),
                      getLanguageCode(destinationLanguage),
                      languageController.text,
                    );
                  },
                  child: const Text('Translate'),
                ),
              ),
              const SizedBox(height: 20),
              if (output.isNotEmpty)
                Card(
                  color: const Color(0xff2b3c5a),
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      output,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
