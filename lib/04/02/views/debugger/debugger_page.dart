import 'package:flutter/material.dart';
import 'provider/change_notifier_proxy_provider_test_item.dart';
import 'provider/future_provider_test_item.dart';
import 'provider/listenable_provider_test_item.dart';
import 'package:provider/provider.dart';
import 'provider/change_notifier_provider_test_item.dart';
import 'provider/provider_test_item.dart';
import 'provider/proxy_provider_test_item.dart';
import 'provider/stream_provider_test_item.dart';

class DebuggerPage extends StatelessWidget {
  const DebuggerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('功能测试'),
        // backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Container(height: 15),

          Provider(
            // lazy: false,
            create: (_) => DataModel(),
            dispose: (_, model) => model.dispose(),
            child: const ProviderTestItem(),
          ),
          const Divider(),
          const AnimationWrapper(
            child: ListenableProviderTestItem(),
          ),
          const Divider(),
          ChangeNotifierProvider(
            create: (_) => CountModel(),
            child: const ChangeNotifierProviderTestItem(),
          ),
          const Divider(),
          FutureProvider<NetState>(
            initialData: NetLoading(),
            create: Api.query,
            catchError: (_, __) => NetFailure('error'),
            child: const FutureProviderTestItem(),
          ),
          StreamProvider<SignalState>(
            initialData: SignalState(counter: 10, type: SignalType.denial),
            create: (_) => SignalStream().createStream(count: 1000),
            catchError: (_, __) =>
                SignalState(counter: -1, type: SignalType.wait),
            child: const StreamProviderTestItem(),
          ),
          Container(height: 15),
          ChangeNotifierProvider(
            create: (_) => CountModel(),
            child: ProxyProvider<CountModel, CountStringModel>(
                update: (BuildContext context, CountModel value, CountStringModel? previous) {
                  return CountStringModel.fromInt(value.counter);
                },
                child: const ProxyProviderTestItem()),
          ),
          const Divider(),
          ChangeNotifierProvider(
            create: (_) => CountModel(),
            child: ChangeNotifierProxyProvider<CountModel, ColorModel>(
                update: (BuildContext context, CountModel value, ColorModel? previous) {
                  return previous!..update(value);
                },
                create: (BuildContext context)=>ColorModel(),
                child: const ChangeNotifierProxyProviderTestItem()),
          ),
        ],
      ),
    );
  }
}
