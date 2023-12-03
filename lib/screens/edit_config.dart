// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jellyfiner/api/auth.dart';
import 'package:jellyfiner/types/server_config.dart';
import 'package:jellyfiner/utils/configs_manager.dart';
import 'package:jellyfiner/utils/custom_colors.dart';

class EditConfig extends StatefulWidget {
  final ServerConfig config;
  const EditConfig({super.key, required this.config});

  @override
  State<StatefulWidget> createState() => _EditConfigState();
}

class _EditConfigState extends State<EditConfig> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _serverController = TextEditingController();
  final TextEditingController _configName = TextEditingController();
  late bool isDefault;
  bool showPassword = false;
  bool isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _serverController.dispose();
    _configName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _usernameController.text = widget.config.username;
    _serverController.text = widget.config.serverUrl;
    _configName.text = widget.config.configName;
    isDefault = widget.config.isDefault;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Edit Config"),
          elevation: 0,
          backgroundColor: CustomColors.darkPrimary,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () async {
              Navigator.of(context)
                  .pop(await Future.wait(await ConfigsManager.getAllConfigs()));
            },
          )),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .05),
              height: mediaQuery.height * .50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: _configName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Configuration name is empty";
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.nunitoSans(),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: Icon(
                        CupertinoIcons.pen,
                        color: CustomColors.lightPrimary,
                      ),
                      hintText: "Configuration Name",
                      hintStyle: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w600,
                        color: Colors.black38,
                      ),
                      fillColor: Colors.black12,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _serverController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Server address is empty";
                      } else if (!value.startsWith("http")) {
                        return "Server address must start with http or https";
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.nunitoSans(),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        prefixIcon: Icon(
                          CupertinoIcons.globe,
                          color: CustomColors.lightPrimary,
                        ),
                        hintText: "Server Address",
                        hintStyle: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.black38,
                        ),
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  ),
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username is empty";
                      } else {
                        return null;
                      }
                    },
                    style: GoogleFonts.nunitoSans(),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        prefixIcon: Icon(
                          CupertinoIcons.person,
                          color: CustomColors.lightPrimary,
                        ),
                        hintText: "Username",
                        hintStyle: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.black38,
                        ),
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  ),
                  TextFormField(
                    obscureText: !showPassword,
                    controller: _passwordController,
                    style: GoogleFonts.nunitoSans(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5),
                        prefixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            color: CustomColors.lightPrimary,
                          ),
                          onPressed: () {
                            setState(() => showPassword = !showPassword);
                          },
                        ),
                        hintText: "Password",
                        hintStyle: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.black38,
                        ),
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Set as default config",
                        style: GoogleFonts.nunitoSans(),
                      ),
                      Checkbox(
                        value: isDefault,
                        onChanged: (value) {
                          setState(() {
                            isDefault = !isDefault;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (isLoading) {
                        return;
                      }
                      bool? isValid = _formKey.currentState?.validate();
                      if (isValid == null || !isValid) {
                        return;
                      }
                      if (await ConfigsManager.getConfig(_configName.text) !=
                              null &&
                          widget.config.configName != _configName.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                                "Configuration name already exists, please choose another one"),
                            backgroundColor: CustomColors.red,
                          ),
                        );
                        return;
                      }
                      setState(() => isLoading = true);
                      String error = await AuthApi.login(
                        _usernameController.text,
                        _passwordController.text,
                        _serverController.text,
                        _configName.text,
                        isDefault,
                      );
                      if (error.isNotEmpty) {
                        setState(() => isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                            backgroundColor: CustomColors.red,
                          ),
                        );
                      } else {
                        if (widget.config.configName != _configName.text) {
                          ConfigsManager.deleteConfig(widget.config.configName);
                        }
                        Navigator.of(context).pop(await Future.wait(
                            await ConfigsManager.getAllConfigs()));
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: mediaQuery.width * .125,
                          vertical: mediaQuery.height * .015,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        CustomColors.darkAccent,
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: CustomColors.darkPrimary,
                          )
                        : Text(
                            "Login",
                            style: GoogleFonts.nunitoSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: mediaQuery.width * .04,
                            ),
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (isLoading) {
                        return;
                      }
                      ConfigsManager.deleteConfig(_configName.text);
                      Navigator.of(context).pop(await Future.wait(
                          await ConfigsManager.getAllConfigs()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: mediaQuery.width * .125,
                          vertical: mediaQuery.height * .015,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        CustomColors.red,
                      ),
                    ),
                    child: Text(
                      "Delete",
                      style: GoogleFonts.nunitoSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: mediaQuery.width * .04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
