import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:istate/utils/toast.dart';
import 'package:refresh/refresh.dart';

import '../../river/river.dart';
import '../../data/data.dart';
import 'slider_item_wrapper.dart';

typedef SecretOpCallBack = void Function(BuildContext, ListOpType);

class SecretsListView extends ConsumerStatefulWidget {
  final SecretsState state;
  final SecretOpCallBack onOp;

  const SecretsListView({super.key, required this.state, required this.onOp});

  @override
  ConsumerState<SecretsListView> createState() => _SecretsListViewState();
}

class _SecretsListViewState extends ConsumerState<SecretsListView> {
  final RefreshController _ctrl = RefreshController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(secretListOpProvider, (p, n) => _listenOpChange(context, p, n));
    return SlidableAutoCloseBehavior(
      child: SmartRefresher(
        footer: const ClassicFooter(
          loadingText: "数据加载中...",
          idleText: "上拉加载更多",
          failedText: "数据加载失败",
          loadingIcon: CupertinoActivityIndicator(),
          noDataText: "没有更多数据了",
        ),
        header: const ClassicHeader(
            failedText: "刷新失败",
            refreshingText: "数据加载中...",
            releaseText: "释放刷新",
            idleText: "下拉加载",
            completeText: "刷新成功",
            refreshingIcon: CupertinoActivityIndicator()),
        controller: _ctrl,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _loadNextPage,
        child: ListView.builder(
          itemCount: widget.state.secrets.length,
          itemBuilder: (_, i) => _buildItem(context, widget.state.secrets[i]),
        ),
      ),
    );
  }

  void _listenOpChange(
    BuildContext context,
    AsyncValue<SecretListOpState?>? previous,
    AsyncValue<SecretListOpState?> next,
  ) {
    if (handleError(previous, next)) return;

    if (previous?.value?.op is NoneOp && next.value?.op is RefreshOp) {
      /// 更新成功
      Object? secret = next.value?.data;
      if (secret is PagedResult<Secret>) {
        context.success("领域秘钥数据已更新!");
        _ctrl.refreshCompleted();
      }
    }

    if (previous?.value?.op is NoneOp && next.value?.op is LoadMoreOp) {
      /// 更新成功
      Object? result = next.value?.data;
      if (result is PagedResult<Secret>) {
        if (result.data.isNotEmpty) {
          _ctrl.loadComplete();
        } else {
          _ctrl.loadNoData();
          Future.delayed(const Duration(seconds: 3), () {
            _ctrl.resetNoData();
          });
        }
      }
    }
  }

  Widget _buildItem(BuildContext context, Secret secret) {
    const TextStyle tailStyle = TextStyle(color: Colors.grey);
    return SliderItemWrapper(
      uniqueId: secret.title,
      onDelete: (ctx) => widget.onOp(ctx, DeleteOp(secret)),
      onEdit: (ctx) => widget.onOp(ctx, EditOp(secret)),
      child: ListTile(
        dense: true,
        onTap: () => widget.onOp(context, JumpOp(secret)),
        title: Text(secret.title),
        subtitle: Text(secret.secretStr),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('创建:${secret.createStr}', style: tailStyle),
            Text('更新:${secret.updateStr}', style: tailStyle)
          ],
        ),
      ),
    );
  }

  // void _showDeleteDialog(BuildContext context,Secret record) async {
  //   // Color color = Theme.of(context).backgroundColor;
  //   // await showDialog(
  //   //     context: context,
  //   //     builder: (_) => Dialog(
  //   //       backgroundColor: color,
  //   //       child: PhoneDeleteRecord(
  //   //         model: record,
  //   //       ),
  //   //     ));
  // }
  //
  // void _showEditDialog(BuildContext context,Secret record) {
  //   // Slidable.of(context)?.close();
  //   // Navigator.of(context).push(
  //   //   MaterialPageRoute(builder: (_) => RecordEditPage(record: record)),
  //   // );
  // }

  bool handleError(
    AsyncValue<SecretListOpState?>? previous,
    AsyncValue<SecretListOpState?> next,
  ) {
    bool hasError = (previous?.isLoading ?? true) && next.hasError;
    if (hasError) {
      if (SecretListOp.lastErrorOp is RefreshOp) {
        context.error(next.error.toString());
        _ctrl.refreshFailed();
      }
      if (SecretListOp.lastErrorOp is LoadMoreOp) {
        _ctrl.loadFailed();
      }
    }
    return hasError;
  }

  void _loadNextPage() {
    ref.read(secretListOpProvider.notifier).loadMore();
  }

  void _onRefresh() {
    ref.read(secretListOpProvider.notifier).refresh();
  }

  void onEdit(BuildContext context) {}
}
