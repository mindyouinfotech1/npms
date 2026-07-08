import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
 State<DeleteAccountPage> createState() =>
      _DeleteAccountPageState();
}

class _DeleteAccountPageState
    extends State<DeleteAccountPage> {
  bool agree = false;

  final List<String> reasons = [
    "I no longer need this account",
    "I have another account",
    "Privacy concerns",
    "Poor service experience",
    "Other",
  ];

  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        title: const Text("Delete Account"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  children: [

                    const CircleAvatar(
                      radius: 35,
                      backgroundColor:
                          Color(0xffffebee),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Delete Your Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Deleting your account is permanent and cannot be undone.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Why are you leaving?",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(
                        border:
                            OutlineInputBorder(),
                        labelText:
                            "Select Reason",
                      ),
                      value: selectedReason,
                      items: reasons
                          .map(
                            (e) =>
                                DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedReason =
                              value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding:
                          const EdgeInsets.all(
                              15),
                      decoration:
                          BoxDecoration(
                        color: Colors
                            .red.shade50,
                        borderRadius:
                            BorderRadius
                                .circular(12),
                      ),
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [

                          Text(
                            "Before deleting your account:",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                              "• Your active orders will be cancelled"),

                          Text(
                              "• Your payment history will be removed"),

                          Text(
                              "• Security deposit refunds may be delayed"),

                          Text(
                              "• This action cannot be undone"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    CheckboxListTile(
                      value: agree,
                      activeColor:
                          Colors.red,
                      contentPadding:
                          EdgeInsets.zero,
                      title: const Text(
                        "I understand and want to permanently delete my account.",
                      ),
                      onChanged: (v) {
                        setState(() {
                          agree = v!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red,
                  foregroundColor:
                      Colors.white,
                ),
                onPressed: agree
                    ? () {
                        _showDeleteDialog(
                            context);
                      }
                    : null,
                icon:
                    const Icon(Icons.delete),
                label: const Text(
                    "Delete My Account"),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:
            const Text("Delete Account?"),
        content: const Text(
          "This action is permanent. Are you sure you want to delete your account?",
        ),
        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),

          ElevatedButton(
            style:
                ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content: Text(
                      "Delete Account API Called"),
                ),
              );

              /// Call Delete Account API here
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}