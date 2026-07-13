import 'package:flutter/material.dart';

/// 显示部分平仓弹框。
///
/// 返回值为最终确认的平仓手数；取消时返回 `null`。
Future<double?> showPartialCloseDialog(
  BuildContext context, {
  double totalLots = 0.05,
  double initialLots = 0.06,
  String symbol = 'XAUUSD',
  String direction = '买入',
  String positionLotsText = '0.05手',
  String floatingProfitText = '+\$75.00',
}) {
  return showGeneralDialog<double>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '关闭部分平仓弹框',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, __, ___) {
      return SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: PartialCloseDialog(
            totalLots: totalLots,
            initialLots: initialLots,
            symbol: symbol,
            direction: direction,
            positionLotsText: positionLotsText,
            floatingProfitText: floatingProfitText,
          ),
        ),
      );
    },
    // transitionBuilder: (context, animation, secondaryAnimation, child) {
    //   final curvedAnimation = CurvedAnimation(
    //     parent: animation,
    //     curve: Curves.easeOutCubic,
    //   );
    //   return SlideTransition(
    //     position: Tween<Offset>(
    //       begin: const Offset(0, 1),
    //       end: Offset.zero,
    //     ).animate(curvedAnimation),
    //     child: FadeTransition(opacity: curvedAnimation, child: child),
    //   );
    // },
  );
}

/// Figma 中“部分平仓”底部弹框。
class PartialCloseDialog extends StatefulWidget {
  const PartialCloseDialog({
    super.key,
    required this.totalLots,
    required this.initialLots,
    required this.symbol,
    required this.direction,
    required this.positionLotsText,
    required this.floatingProfitText,
  });

  /// 当前持仓总手数。
  final double totalLots;

  /// 弹框默认显示的平仓手数。
  final double initialLots;

  /// 交易品种名称。
  final String symbol;

  /// 方向文案，例如“买入”“卖出”。
  final String direction;

  /// 持仓手数展示文案。
  final String positionLotsText;

  /// 当前浮盈浮亏展示文案。
  final String floatingProfitText;

  @override
  State<PartialCloseDialog> createState() => _PartialCloseDialogState();
}

class _PartialCloseDialogState extends State<PartialCloseDialog> {
  static const double _minimumLots = 0.01;
  static const double _stepLots = 0.01;

  late double _selectedLots;

  @override
  void initState() {
    super.initState();
    _selectedLots = widget.initialLots;
  }

  bool get _isValidRange =>
      _selectedLots >= _minimumLots && _selectedLots <= widget.totalLots;

  String get _selectedLotsText => _formatLots(_selectedLots);

  String get _rangeTips =>
      '平台范围为${_formatLots(_minimumLots)}～${_formatLots(widget.totalLots)}';

  double get _currentProfitValue {
    final sanitized = widget.floatingProfitText.replaceAll(RegExp(r'[^0-9.-]'), '');
    return double.tryParse(sanitized) ?? 0;
  }

  double get _profitRatio {
    if (widget.totalLots == 0) {
      return 0;
    }
    return (_selectedLots / widget.totalLots).clamp(0, 1);
  }

  double get _estimatedProfit => _currentProfitValue * _profitRatio;

  double get _releasedMargin => 25 * _profitRatio;

  void _updateLots(double value) {
    setState(() {
      _selectedLots = double.parse(value.toStringAsFixed(2));
    });
  }

  void _increaseLots() {
    _updateLots(_selectedLots + _stepLots);
  }

  void _decreaseLots() {
    _updateLots((_selectedLots - _stepLots).clamp(0, 999));
  }

  void _applyFraction(double ratio) {
    _updateLots(widget.totalLots * ratio);
  }

  String _formatLots(double value) {
    return value.toStringAsFixed(2);
  }

  String _formatMoney(double value) {
    final prefix = value >= 0 ? '+' : '-';
    return '$prefix\$${value.abs().toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: const BoxDecoration(
          color: Color(0xFFF4F6F9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildQuantityCard(),
              const SizedBox(height: 12),
              _buildResultCard(),
              const SizedBox(height: 24),
              _buildActionButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Spacer(),
            const Text(
              '平仓',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1F23),
              ),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                width: 24,
                height: 24,
                child: Icon(Icons.close, size: 20, color: Color(0xFF4A5568)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.symbol,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1F23),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF8F2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.direction,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF26A57D),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.positionLotsText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF878E9C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              widget.floatingProfitText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF26A57D),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityCard() {
    final quickActions = <({String label, double ratio})>[
      (label: '全部', ratio: 1),
      (label: '1/2', ratio: 0.5),
      (label: '1/3', ratio: 1 / 3),
      (label: '1/4', ratio: 0.25),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '平仓数量（手）',
            style: TextStyle(fontSize: 15, color: Color(0xFF878E9C)),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedLotsText,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1F23),
                  ),
                ),
              ),
              _buildStepButton(
                icon: Icons.remove,
                onTap: _decreaseLots,
              ),
              const SizedBox(width: 12),
              _buildStepButton(
                icon: Icons.add,
                onTap: _increaseLots,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE2EAF1)),
          const SizedBox(height: 8),
          Text(
            _rangeTips,
            style: const TextStyle(fontSize: 12, color: Color(0xFFF8510E)),
          ),
          const SizedBox(height: 16),
          Row(
            children: quickActions
                .map(
                  (item) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: item == quickActions.last ? 0 : 8,
                      ),
                      child: _buildQuickActionButton(
                        label: item.label,
                        onTap: () => _applyFraction(item.ratio),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow('本次平仓盈亏', _formatMoney(_estimatedProfit), true),
          const SizedBox(height: 18),
          _buildInfoRow(
            '释放保证金',
            '\$${_releasedMargin.abs().toStringAsFixed(2)}',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool highlight) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: Color(0xFF878E9C)),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: highlight ? const Color(0xFF26A57D) : const Color(0xFF1E1F23),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: _isValidRange
            ? () => Navigator.of(context).pop(_selectedLots)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1676FE),
          disabledBackgroundColor: const Color(0xFF1676FE).withOpacity(0.5),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          '平仓 $_selectedLotsText手',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildStepButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F5FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF4A5568)),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(32),
        backgroundColor: const Color(0xFFEAF2FF),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        foregroundColor: const Color(0xFF1676FE),
        padding: EdgeInsets.zero,
      ),
      child: Text(label, style: const TextStyle(fontSize: 15)),
    );
  }
}
