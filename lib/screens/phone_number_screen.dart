// import 'package:flutter/material.dart';

// class PhoneNumberScreen extends StatefulWidget {
//   const PhoneNumberScreen({super.key});

//   @override
//   State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
// }

// class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firebase Authentication'),
//       ),

//     );
//   }
// }

import 'package:country_calling_code_picker/picker.dart';
import 'package:firebase_authentication/resources/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _controller = TextEditingController();
  Country? _selectedCountry;
  String? _contryCode;
  bool _isLoading = false;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getCountryByCountryCode(context, 'IN');
    setState(() {
      _selectedCountry = country;
      _contryCode = country?.callingCode;
    });
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      print(country.name);
      setState(() {
        _contryCode = country.callingCode;
        // _countryFlag = country.name.toLowerCase();
        _selectedCountry = country;
      });
    }
  }

  void onClick(BuildContext context) async {
    String phoneNumber = _contryCode! + _controller.text;
    print(phoneNumber);

    await AuthMethods().signInWithPhone(phoneNumber, context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final country = _selectedCountry;
    return Scaffold(
      body: _selectedCountry != null
          ? Stack(
              children: [
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 36,
                          color: Colors.black,
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Please enter your mobile number",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: const Text(
                                      "you'll receive a 6 digit code to verify next",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 300,
                                height: 50,
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: _showCountryPicker,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            country!.flag,
                                            package: countryCodePackageName,
                                            width: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            _contryCode!,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: TextField(
                                          controller: _controller,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Mobile Number',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    onClick(context);
                                  },
                                  child: const Text(
                                    "Next",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
