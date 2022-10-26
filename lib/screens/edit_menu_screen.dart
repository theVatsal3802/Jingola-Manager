import 'package:flutter/material.dart';

import '../functions/other_functions.dart';

class EditMenuScreen extends StatefulWidget {
  static const routeName = "/edit-menu";
  final String id;
  final Map<String, dynamic>? data;
  const EditMenuScreen({
    super.key,
    required this.id,
    required this.data,
  });

  @override
  State<EditMenuScreen> createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final priceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late Future<bool> isEdit;
  String link = "";
  String price = "";
  String desc = "";
  bool isLoading = false;

  Future<bool> isEditing() async {
    if (widget.data == null) {
      return false;
    }
    setState(() {
      nameController.text = widget.data!["name"];
      link = widget.data!["imageUrl"];
      desc = widget.data!["description"];
      price = widget.data!["price"];
      descriptionController.text = widget.data!["description"];
      categoryController.text = widget.data!["category"];
      imageUrlController.text = widget.data!["imageUrl"];
      priceController.text = widget.data!["price"];
    });
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    imageUrlController.dispose();
    priceController.dispose();
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
          "Edit Menu Item",
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
                                "Name: ${nameController.text}",
                                textScaleFactor: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                                    Icons.post_add,
                                  ),
                                  labelText: "Name",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter item name";
                                  }
                                  return null;
                                },
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        snapshot.data ?? false
                            ? Text(
                                "Category: ${categoryController.text}",
                                textScaleFactor: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              )
                            : TextFormField(
                                key: const ValueKey("category"),
                                autocorrect: true,
                                controller: categoryController,
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
                          keyboardType: TextInputType.url,
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
                        TextFormField(
                          key: const ValueKey("description"),
                          autocorrect: true,
                          controller: descriptionController,
                          enableSuggestions: true,
                          keyboardType: TextInputType.multiline,
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
                              Icons.description,
                            ),
                            labelText: "Description",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter some description";
                            }
                            return null;
                          },
                          maxLines: 3,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          key: const ValueKey("price"),
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.none,
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
                                Icons.description,
                              ),
                              labelText: "Price",
                              prefixText: "₹"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter price";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        snapshot.data ?? false
                            ? Text(
                                "Vegetarian: ${widget.data!["isVeg"]}",
                                textScaleFactor: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: widget.data!["isVeg"]
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 20,
                        ),
                        if (isLoading)
                          const CircularProgressIndicator.adaptive(),
                        if (!isLoading)
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              FocusScope.of(context).unfocus();
                              bool valid = _formKey.currentState!.validate();
                              if (!valid) {
                                setState(() {
                                  isLoading = false;
                                });
                                return;
                              }
                              if (link == imageUrlController.text.trim() &&
                                  price == priceController.text.trim() &&
                                  desc == descriptionController.text.trim()) {
                                setState(() {
                                  isLoading = false;
                                });
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
                                return;
                              }
                              _formKey.currentState!.save();
                              snapshot.data!
                                  ? await OtherFunctions.updateMenuItem(
                                      id: widget.id,
                                      imageUrl: imageUrlController.text.trim(),
                                      description:
                                          descriptionController.text.trim(),
                                      price: double.parse(
                                        priceController.text.trim(),
                                      ),
                                      context: context,
                                    ).then(
                                      (value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Menu Item updated successfully",
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : await OtherFunctions.addMenuItem(
                                      name: nameController.text.trim(),
                                      imageUrl: imageUrlController.text.trim(),
                                      category: categoryController.text.trim(),
                                      description:
                                          descriptionController.text.trim(),
                                      price: double.parse(
                                          priceController.text.trim()),
                                      isVeg: true,
                                      context: context,
                                    ).then(
                                      (_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Menu Item added successfully",
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: const Text(
                              "Save Menu Item",
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
