import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataModel{
  late String _largeData = '*'*100000;

  String get largeData =>_largeData;

  DataModel(){
    _largeData = '*'*100000;
    print("====CountModel 创建===========");
  }


  void dispose(){
    _largeData = '';
    print("====CountModel#dispose===========");
  }
}

class ProviderTestItem extends StatefulWidget {
  const ProviderTestItem({super.key});

  @override
  State<ProviderTestItem> createState() => _ProviderTestItemState();
}

class _ProviderTestItemState extends State<ProviderTestItem> {
  String _data = '点击时，获取 Provider 中存储的数据';

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    const TextStyle subStyle = TextStyle(fontSize: 12, color: Colors.grey);
    const TextStyle titleStyle = TextStyle(fontSize: 16);
    return ListTile(
      leading: Icon(Icons.transfer_within_a_station, color: primaryColor),
      title: const Text('Provider 测试', style: titleStyle),
      subtitle: Text(
        _data,
        style: subStyle,
        maxLines: 1,
      ),
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    /// 访问提供器中的数据
    DataModel model = context.read<DataModel>();
    _data = model.largeData;
    setState(() {});
    print(model.largeData);
  }
}