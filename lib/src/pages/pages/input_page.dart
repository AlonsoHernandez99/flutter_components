import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _name = "";
  String _email = "";
  String _password = "";
  String _date = "";
  String _power = "Fly";

  List<String> _skills = ["Fly", "Destroy", "Sex", "Die", "Etc"];

  TextEditingController _inputDateFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inputs Text"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: [
            _createField(),
            Divider(),
            _createEmail(),
            Divider(),
            _createPassword(),
            Divider(),
            _createDate(context),
            Divider(),
            _createDropdown(),
            Divider(),
            _createPerson()
          ],
        ));
  }

  Widget _createField() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        counter: Text("${_name.trim().length}"),
        hintText: "Name",
        labelText: "Name",
        helperText: "Only name",
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            _name = value;
          });
        }
      },
    );
  }

  Widget _createPerson() {
    return ListTile(
      title: Text('Name: $_name'),
      subtitle: Text("Email: $_email"),
      trailing: Text(_power),
    );
  }

  Widget _createEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: "Email",
        labelText: "Email",
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            _email = value;
          });
        }
      },
    );
  }

  Widget _createPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: "Password",
        labelText: "Password",
        suffixIcon: Icon(Icons.lock),
        icon: Icon(Icons.lock_outline_rounded),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            _password = value;
          });
        }
      },
    );
  }

  Widget _createDate(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputDateFieldController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: "BirthDate",
        labelText: "BirthDate",
        suffixIcon: Icon(Icons.calendar_today_outlined),
        icon: Icon(Icons.calendar_today_sharp),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _inputDateFieldController.text = _date;
      });
    }
  }

  List<DropdownMenuItem<String>> getOptions() {
    List<DropdownMenuItem<String>> list = new List();
    _skills.forEach((power) {
      list.add(DropdownMenuItem(child: Text(power), value: power));
    });
    return list;
  }

  Widget _createDropdown() {
    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: DropdownButton(
            value: _power,
            items: getOptions(),
            onChanged: (opt) {
              setState(() {
                _power = opt;
              });
            },
          ),
        )
      ],
    );
  }
}
