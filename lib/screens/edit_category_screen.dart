import 'package:flutter/material.dart';

import '../functions/other_functions.dart';

class EditCategoryScreen extends StatefulWidget {
  static const routeName = "/edit-category";
  final Map<String, dynamic>? data;
  final String id;

  const EditCategoryScreen({
    super.key,
    required this.data,
    required this.id,
  });

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late Future<bool> isEdit;
  String link = "";
  bool isLoading = false;

  Future<bool> isEditing() async {
    if (widget.data == null) {
      return false;
    }
    setState(() {
      nameController.text = widget.data!["name"];
      link = widget.data!["imageUrl"];
      imageUrlController.text = widget.data!["imageUrl"];
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    isEdit = isEditing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Category",
          textScaleFactor: 1,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: isEdit,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
                  Image.asset(
                    "assets/images/name.png",
                    fit: BoxFit.cover,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        snapshot.data ?? false
                            ? Text(
                                nameController.text,
                                textScaleFactor: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              )
                            : TextFormField(
                                key: const ValueKey("name"),
                                autocorrect: true,
                                controller: nameController,
                                enableSuggestions: true,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.5,
                                      color: Colors.black54,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.category,
                                  ),
                                  labelText: "Category",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter category name";
                                  }
                                  return null;
                                },
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          key: const ValueKey("imageUrl"),
                          autocorrect: true,
                          controller: imageUrlController,
                          enableSuggestions: true,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0.5,
                                color: Colors.black54,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(
                              Icons.image,
                            ),
                            labelText: "Display Image",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter display image URL";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        if (isLoading)
                          const CircularProgressIndicator.adaptive(),
                        if (!isLoading)
                          ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              bool valid = _formKey.currentState!.validate();
                              if (!valid) {
                                return;
                              }
                              if (link == imageUrlController.text.trim()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      "You have not changed any data. Please change something before saving.",
                                      textScaleFactor: 1,
                                    ),
                                    action: SnackBarAction(
                                      label: "OK",
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                );
                              }
                              _formKey.currentState!.save();
                              snapshot.data!
                                  ? await OtherFunctions.updateCategory(
                                      widget.id,
                                      imageUrlController.text.trim(),
                                    )
                                  : await OtherFunctions.addCategory(
                                      nameController.text.trim(),
                                      imageUrlController.text.trim(),
                                    ).then(
                                      (_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              snapshot.data ?? false
                                                  ? "Category updated successfully"
                                                  : "Category added successfully",
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                            child: const Text(
                              "Save Category",
                              textScaleFactor: 1,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
