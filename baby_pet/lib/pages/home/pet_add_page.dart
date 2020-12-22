import 'package:flutter/material.dart';
import '../../models/pet_model.dart';
import '../../exports.dart';
import 'views/pet_select_cell.dart';
import 'views/pet_text_input_cell.dart';

class PetAddPage extends StatefulWidget {
  final PetModel model;
  const PetAddPage({Key key, this.model}) : super(key: key);

  @override
  _PetAddPageState createState() => _PetAddPageState();
}

class _PetAddPageState extends State<PetAddPage> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _nicknameController;
  TextEditingController _weightController;

  String _petSex = '';
  String _nickname = '';
  String _petWeight = '';
  bool _disabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _petSex = widget.model.sex == '0' ? 'GG' : 'MM';
    _nickname = widget.model?.petName ?? '';
    _petWeight = widget.model.petKg;
    _nicknameController = TextEditingController(text: _nickname);
    _weightController = TextEditingController(text: _petWeight);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nicknameController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void updateButtonState() {
    final disable =
        _petSex.length > 0 && _nickname.length > 0 && _petWeight.length > 0;
    setState(() {
      _disabled = disable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑宠物'),
      ),
      body: GestureDetector(
        onTap: () {
          _inputFocusNode(context);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              _animalHeaderItem(),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(
                  '必填',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              PetTextInputCell(
                controller: _nicknameController,
                leftTitle: '昵称',
                placeholder: '请输入宠物昵称',
                onChanged: (text) {
                  _nickname = text;
                  updateButtonState();
                },
              ),
              PetSelectCell(
                leftTitle: '性别',
                rightTitle: _petSex,
                onTap: () {
                  _inputFocusNode(context);
                  ActionSheet.showActionSheet(context, rows: ['GG', 'MM'],
                      selectAction: (index, title) {
                    _petSex = title;
                    updateButtonState();
                    print(index);
                  });
                },
              ),
              PetSelectCell(
                leftTitle: '宠物品种',
                rightTitle: _petSex,
                onTap: () {
                  _inputFocusNode(context);
                  ActionSheet.showActionSheet(context, rows: ['GG', 'MM'],
                      selectAction: (index, title) {
                    _petSex = title;
                    updateButtonState();
                    print(index);
                  });
                },
              ),
              PetSelectCell(
                leftTitle: '出生日期',
                rightTitle: _petSex,
                onTap: () {
                  _inputFocusNode(context);
                  ActionSheet.showActionSheet(context, rows: ['GG', 'MM'],
                      selectAction: (index, title) {
                    _petSex = title;
                    updateButtonState();
                    print(index);
                  });
                },
              ),
              PetSelectCell(
                leftTitle: '领养日期',
                rightTitle: _petSex,
                onTap: () {
                  _inputFocusNode(context);
                  ActionSheet.showActionSheet(context, rows: ['GG', 'MM'],
                      selectAction: (index, title) {
                    _petSex = title;
                    updateButtonState();
                    print(index);
                  });
                },
              ),
              PetSelectCell(
                leftTitle: '绝育状态',
                rightTitle: _petSex,
                onTap: () {
                  _inputFocusNode(context);
                  ActionSheet.showActionSheet(context, rows: ['GG', 'MM'],
                      selectAction: (index, title) {
                    _petSex = title;
                    updateButtonState();
                    print(index);
                  });
                },
              ),
              PetTextInputCell(
                controller: _weightController,
                keyboardType: TextInputType.number,
                leftTitle: '宠物体重',
                placeholder: '请输入宠物体重',
                onChanged: (text) {
                  _petWeight = text;
                  updateButtonState();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animalHeaderItem() {
    return Container(
      height: 130,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          ExtendCachedNetworkImage(
            width: 70,
            height: 70,
            corner: 35,
            imageUrl: widget.model?.petImg ?? '',
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Utils.getImgPath('animal_change'),
                width: 12,
                height: 10,
              ),
              Text(
                '上传头像',
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _inputFocusNode(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
