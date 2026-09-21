import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../modules/pages/business/net_profit_loss/model/profit_loss_model.dart';
import '../../../modules/pages/business/real_estate_development/business_project_details/model/project_pdf_model.dart';
import '../../../modules/pages/business/real_estate_development/business_project_details/model/real_state_project_model.dart';
import '../constants/app_images.dart';
import '../constants/app_strings.dart';

class _MadarPdf {
  _MadarPdf._();

  static const fontAsset = 'assets/fonts/app_font.ttf';
  static const slate = PdfColor.fromInt(0xFF0F172A);
  static const muted = PdfColor.fromInt(0xFF64748B);
  static const border = PdfColor.fromInt(0xFFE2E8F0);
  static const cardBg = PdfColor.fromInt(0xFFF8FAFC);
  static const tableHead = PdfColor.fromInt(0xFFF1F5F9);
  static const heading = PdfColor.fromInt(0xFF334155);
  static const tableLabel = PdfColor.fromInt(0xFF475569);
  static const positive = PdfColor.fromInt(0xFF16A34A);
  static const negative = PdfColor.fromInt(0xFFDC2626);
  static const primary = PdfColor.fromInt(0xFF2563EB);
  static const successBg = PdfColor.fromInt(0xFFDCFCE7);
  static const successText = PdfColor.fromInt(0xFF15803D);
  static const warningBg = PdfColor.fromInt(0xFFFEF3C7);
  static const warningText = PdfColor.fromInt(0xFFB45309);
  static const insightBg = PdfColor.fromInt(0xFFFFFBEB);
  static const insightBorder = PdfColor.fromInt(0xFFFEF3C7);
  static const insightText = PdfColor.fromInt(0xFF92400E);
  static const progressTrack = PdfColor.fromInt(0xFFE2E8F0);
  static const progressBox = PdfColor.fromInt(0xFFF1F5F9);

  static pw.Font? font;
  static pw.MemoryImage? logo;

  static Future<void> ensureAssets() async {
    font ??= pw.Font.ttf(await rootBundle.load(fontAsset));
    logo ??= pw.MemoryImage(
      (await rootBundle.load(AppImages.logo)).buffer.asUint8List(),
    );
  }

  static pw.PageTheme pageTheme() {
    return pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(28),
      theme: pw.ThemeData.withFont(base: font!, bold: font!),
      textDirection: pw.TextDirection.rtl,
    );
  }

  static pw.Widget rtlText(
    String text, {
    double size = 12,
    PdfColor color = slate,
    pw.FontWeight weight = pw.FontWeight.normal,
    pw.TextAlign align = pw.TextAlign.right,
  }) {
    return pw.Text(
      text,
      textDirection: pw.TextDirection.rtl,
      textAlign: align,
      style: pw.TextStyle(fontSize: size, color: color, fontWeight: weight),
    );
  }

  static pw.Widget header({required String title, String? subtitle}) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  rtlText(title, size: 18, weight: pw.FontWeight.bold),
                  if (subtitle != null && subtitle.isNotEmpty) ...[
                    pw.SizedBox(height: 4),
                    rtlText(subtitle, size: 11, color: muted),
                  ],
                ],
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Image(logo!, width: 48, height: 48),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Divider(color: border, thickness: 1.2),
      ],
    );
  }

  static pw.Widget metricCard({
    required String title,
    required String value,
    PdfColor valueColor = slate,
  }) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          color: cardBg,
          border: pw.Border.all(color: border),
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            rtlText(title, size: 10, color: muted),
            pw.SizedBox(height: 6),
            rtlText(value, size: 13, color: valueColor, weight: pw.FontWeight.bold),
          ],
        ),
      ),
    );
  }

  static pw.Widget sectionTitle(String title) {
    return rtlText(title, size: 14, weight: pw.FontWeight.bold, color: heading);
  }

  static Future<void> saveAndOpen(pw.Document doc, String filePrefix) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(
      '${dir.path}/${filePrefix}_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await doc.save());
    final result = await OpenFile.open(file.path, type: 'application/pdf');
    if (result.type != ResultType.done) {
      throw Exception(result.message);
    }
  }
}

class PdfReportGenerator {
  static String _formatNumber(double number) {
    return number
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  static String _formatAmount(double number) {
    return '${_formatNumber(number)} ${AppStrings.currency}';
  }

  static String _formatPercent(double percent) {
    final sign = percent > 0 ? '+' : '';
    return '$sign${percent.toStringAsFixed(1)}%';
  }

  static pw.Widget _tableCell(
    String text, {
    PdfColor color = _MadarPdf.slate,
    bool header = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: _MadarPdf.rtlText(
        text,
        size: 11,
        color: color,
        weight: header ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    );
  }

  static Future<void> generateAndOpen({
    required double totalIncome,
    required double totalExpenses,
    required double netProfit,
    required ProfitLossComparisonItem incomeComparison,
    required ProfitLossComparisonItem expensesComparison,
    required ProfitLossComparisonItem netProfitComparison,
    required List<String> insights,
  }) async {
    await _MadarPdf.ensureAssets();
    final notes = insights.isEmpty ? const ['—'] : insights;
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageTheme: _MadarPdf.pageTheme(),
        build: (context) => [
          _MadarPdf.header(title: 'التقرير والتحليل المالي'),
          pw.SizedBox(height: 18),
          pw.Row(
            children: [
              _MadarPdf.metricCard(
                title: 'إجمالي الدخل',
                value: _formatAmount(totalIncome),
                valueColor: _MadarPdf.positive,
              ),
              pw.SizedBox(width: 10),
              _MadarPdf.metricCard(
                title: 'إجمالي المصروفات',
                value: _formatAmount(totalExpenses),
                valueColor: _MadarPdf.negative,
              ),
              pw.SizedBox(width: 10),
              _MadarPdf.metricCard(
                title: 'صافي الربح',
                value: _formatAmount(netProfit),
                valueColor: netProfit < 0 ? _MadarPdf.negative : _MadarPdf.positive,
              ),
            ],
          ),
          pw.SizedBox(height: 22),
          _MadarPdf.sectionTitle('مقارنة بالأداء السابق'),
          pw.SizedBox(height: 10),
          pw.Table(
            border: const pw.TableBorder(
              horizontalInside: pw.BorderSide(color: _MadarPdf.border),
              bottom: pw.BorderSide(color: _MadarPdf.border),
            ),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: _MadarPdf.tableHead),
                children: [
                  _tableCell('نسبة التغير', header: true, color: _MadarPdf.tableLabel),
                  _tableCell('قيمة التغير', header: true, color: _MadarPdf.tableLabel),
                  _tableCell('البند', header: true, color: _MadarPdf.tableLabel),
                ],
              ),
              pw.TableRow(
                children: [
                  _tableCell(
                    _formatPercent(incomeComparison.percent),
                    color: incomeComparison.percent < 0
                        ? _MadarPdf.negative
                        : _MadarPdf.positive,
                  ),
                  _tableCell(_formatAmount(incomeComparison.amount)),
                  _tableCell('الدخل'),
                ],
              ),
              pw.TableRow(
                children: [
                  _tableCell(
                    _formatPercent(expensesComparison.percent),
                    color: expensesComparison.percent < 0
                        ? _MadarPdf.negative
                        : _MadarPdf.positive,
                  ),
                  _tableCell(_formatAmount(expensesComparison.amount)),
                  _tableCell('المصروفات'),
                ],
              ),
              pw.TableRow(
                children: [
                  _tableCell(
                    _formatPercent(netProfitComparison.percent),
                    color: netProfitComparison.percent < 0
                        ? _MadarPdf.negative
                        : _MadarPdf.positive,
                  ),
                  _tableCell(_formatAmount(netProfitComparison.amount)),
                  _tableCell('صافي الربح'),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 22),
          _MadarPdf.sectionTitle('التنبيهات والملاحظات المالية'),
          pw.SizedBox(height: 10),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              color: _MadarPdf.insightBg,
              border: pw.Border.all(color: _MadarPdf.insightBorder),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                for (final note in notes) ...[
                  _MadarPdf.rtlText('• $note', size: 11, color: _MadarPdf.insightText),
                  if (note != notes.last) pw.SizedBox(height: 6),
                ],
              ],
            ),
          ),
        ],
      ),
    );
    await _MadarPdf.saveAndOpen(doc, 'financial_report');
  }
}

class ProjectPdfGenerator {
  static String _formatDate(String isoDate) {
    if (isoDate.isEmpty) return '—';
    try {
      final dt = DateTime.parse(isoDate);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
  }

  static bool _isDone(String status, double progress) {
    final value = status.trim().toUpperCase();
    return value == 'COMPLETED' || value == 'DONE' || progress >= 100;
  }

  static pw.Widget _progressBar(double progress, {PdfColor? color}) {
    final filled = progress.clamp(0, 100).round();
    final rest = 100 - filled;
    return pw.ClipRRect(
      horizontalRadius: 6,
      verticalRadius: 6,
      child: pw.Container(
        height: 8,
        color: _MadarPdf.progressTrack,
        child: filled <= 0
            ? pw.SizedBox(height: 8)
            : pw.Row(
                children: [
                  pw.Expanded(
                    flex: filled,
                    child: pw.Container(color: color ?? _MadarPdf.primary),
                  ),
                  if (rest > 0)
                    pw.Expanded(flex: rest, child: pw.SizedBox(height: 8)),
                ],
              ),
      ),
    );
  }

  static pw.Widget _badge(bool isDone) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: pw.BoxDecoration(
        color: isDone ? _MadarPdf.successBg : _MadarPdf.warningBg,
        borderRadius: pw.BorderRadius.circular(12),
      ),
      child: _MadarPdf.rtlText(
        isDone ? 'مكتملة' : 'قيد التنفيذ',
        size: 9,
        color: isDone ? _MadarPdf.successText : _MadarPdf.warningText,
        weight: pw.FontWeight.bold,
      ),
    );
  }

  static pw.Widget _tableCell(pw.Widget child, {bool header = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      color: header ? _MadarPdf.tableHead : null,
      child: child,
    );
  }

  static Future<pw.MemoryImage?> _networkImage(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!uri.hasScheme) return null;
      final client = HttpClient()
        ..connectionTimeout = const Duration(seconds: 8);
      final request = await client.getUrl(uri);
      final response = await request.close().timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) {
        client.close(force: true);
        return null;
      }
      final bytes = await consolidateHttpClientResponseBytes(response);
      client.close();
      if (bytes.isEmpty) return null;
      return pw.MemoryImage(bytes);
    } catch (_) {
      return null;
    }
  }

  static Future<Map<String, pw.MemoryImage>> _loadImages(
    List<TimelineItem> timeline,
  ) async {
    final urls = timeline
        .expand((item) => item.attachments)
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toSet();
    final images = <String, pw.MemoryImage>{};
    await Future.wait(
      urls.map((url) async {
        final image = await _networkImage(url);
        if (image != null) images[url] = image;
      }),
    );
    return images;
  }

  static List<pw.Widget> _stageCards(ProjectDetailsModel data) {
    if (data.stages.isEmpty) {
      return [_MadarPdf.rtlText('لا توجد مراحل', size: 11, color: _MadarPdf.muted)];
    }
    return [
      for (final stage in data.stages)
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 12),
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: _MadarPdf.border),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _MadarPdf.rtlText(
                    '${stage.progress.toInt()}%',
                    size: 16,
                    color: _MadarPdf.primary,
                    weight: pw.FontWeight.bold,
                  ),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        _MadarPdf.rtlText(
                          stage.stageName,
                          size: 13,
                          weight: pw.FontWeight.bold,
                        ),
                        if (stage.description.isNotEmpty) ...[
                          pw.SizedBox(height: 2),
                          _MadarPdf.rtlText(
                            stage.description,
                            size: 10,
                            color: _MadarPdf.muted,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              if (stage.subStages.isNotEmpty) ...[
                pw.SizedBox(height: 10),
                pw.Table(
                  border: const pw.TableBorder(
                    horizontalInside: pw.BorderSide(color: _MadarPdf.border),
                  ),
                  columnWidths: const {
                    0: pw.FlexColumnWidth(1.2),
                    1: pw.FlexColumnWidth(2),
                    2: pw.FlexColumnWidth(3),
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        _tableCell(
                          _MadarPdf.rtlText(
                            'الحالة',
                            size: 10,
                            color: _MadarPdf.tableLabel,
                            weight: pw.FontWeight.bold,
                          ),
                          header: true,
                        ),
                        _tableCell(
                          _MadarPdf.rtlText(
                            'نسبة الإنجاز',
                            size: 10,
                            color: _MadarPdf.tableLabel,
                            weight: pw.FontWeight.bold,
                          ),
                          header: true,
                        ),
                        _tableCell(
                          _MadarPdf.rtlText(
                            'المرحلة الفرعية',
                            size: 10,
                            color: _MadarPdf.tableLabel,
                            weight: pw.FontWeight.bold,
                          ),
                          header: true,
                        ),
                      ],
                    ),
                    for (final sub in stage.subStages)
                      pw.TableRow(
                        children: [
                          _tableCell(
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: _badge(_isDone(sub.status, sub.progress)),
                            ),
                          ),
                          _tableCell(
                            pw.Row(
                              children: [
                                _MadarPdf.rtlText(
                                  '${sub.progress.toInt()}%',
                                  size: 9,
                                  color: _MadarPdf.muted,
                                ),
                                pw.SizedBox(width: 6),
                                pw.Expanded(
                                  child: _progressBar(
                                    sub.progress,
                                    color: _isDone(sub.status, sub.progress)
                                        ? _MadarPdf.positive
                                        : _MadarPdf.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _tableCell(_MadarPdf.rtlText(sub.name, size: 11)),
                        ],
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
    ];
  }

  static List<pw.Widget> _timelineCards(
    ProjectDetailsModel data,
    Map<String, pw.MemoryImage> images,
  ) {
    if (data.timeline.isEmpty) {
      return [
        _MadarPdf.rtlText('لا توجد تحديثات', size: 11, color: _MadarPdf.muted),
      ];
    }
    return [
      for (final item in data.timeline)
        pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10, right: 8),
          padding: const pw.EdgeInsets.only(right: 12, bottom: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              right: pw.BorderSide(color: _MadarPdf.border, width: 2),
            ),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              _MadarPdf.rtlText(
                '${_formatDate(item.date)}${item.stageName.isEmpty ? '' : ' - ${item.stageName}'}',
                size: 10,
                color: _MadarPdf.muted,
              ),
              if (item.content.isNotEmpty) ...[
                pw.SizedBox(height: 4),
                _MadarPdf.rtlText(item.content, size: 12, color: _MadarPdf.heading),
              ],
              if (item.attachments.any((url) => images[url] != null)) ...[
                pw.SizedBox(height: 6),
                pw.Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final url in item.attachments)
                      if (images[url] != null)
                        pw.ClipRRect(
                          horizontalRadius: 6,
                          verticalRadius: 6,
                          child: pw.Image(
                            images[url]!,
                            width: 64,
                            height: 64,
                            fit: pw.BoxFit.cover,
                          ),
                        ),
                  ],
                ),
              ],
            ],
          ),
        ),
    ];
  }

  static Future<void> generateAndOpen(ProjectDetailsModel data) async {
    await _MadarPdf.ensureAssets();
    final images = await _loadImages(data.timeline);
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageTheme: _MadarPdf.pageTheme(),
        build: (context) => [
          _MadarPdf.header(
            title: 'تقرير مشروع: ${data.project.name}',
            subtitle:
                'الموقع: ${data.project.location} | مدير المشروع: ${data.project.manager}',
          ),
          pw.SizedBox(height: 16),
          pw.Row(
            children: [
              _MadarPdf.metricCard(
                title: 'تاريخ البداية',
                value: _formatDate(data.project.startDate),
              ),
              pw.SizedBox(width: 8),
              _MadarPdf.metricCard(
                title: 'تاريخ الانتهاء المتوقع',
                value: _formatDate(data.project.endDate),
              ),
              pw.SizedBox(width: 8),
              _MadarPdf.metricCard(
                title: 'المراحل المكتملة',
                value: '${data.stats.completed} من ${data.stats.totalStages}',
              ),
            ],
          ),
          pw.SizedBox(height: 14),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: _MadarPdf.progressBox,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              children: [
                pw.Row(
                  children: [
                    _MadarPdf.rtlText(
                      '${data.project.overallProgress.toInt()}%',
                      size: 12,
                      color: _MadarPdf.primary,
                      weight: pw.FontWeight.bold,
                    ),
                    pw.Expanded(
                      child: _MadarPdf.rtlText(
                        'إجمالي نسبة الإنجاز للمشروع',
                        size: 11,
                        weight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                _progressBar(data.project.overallProgress),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          _MadarPdf.sectionTitle('تفاصيل مراحل المشروع'),
          pw.SizedBox(height: 10),
          ..._stageCards(data),
          pw.SizedBox(height: 12),
          _MadarPdf.sectionTitle('آخر التحديثات والسجل الزمني'),
          pw.SizedBox(height: 10),
          ..._timelineCards(data, images),
        ],
      ),
    );
    await _MadarPdf.saveAndOpen(doc, 'project_report');
  }

  static Future<void> generateAndOpenFromProject(RealStateProjectModel project) {
    return generateAndOpen(ProjectDetailsModel.fromRealState(project));
  }

  static Future<void> generateAndOpenFromMap(Map<String, dynamic> jsonResponse) {
    return generateAndOpen(ProjectDetailsModel.fromJson(jsonResponse));
  }
}
