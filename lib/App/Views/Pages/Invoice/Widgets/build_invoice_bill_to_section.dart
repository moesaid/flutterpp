import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_company_info.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_highlights_item.dart';
import 'package:flutterpp/Helpers/invoice_helper.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceBillToSection extends StatelessWidget {
  final ClientModel client;
  final InvoiceModel invoice;

  const BuildInvoiceBillToSection({
    super.key,
    required this.client,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.spa),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'bill to'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 6.spa,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 2.spa),
                BuildInvoiceCompanyInfo(
                  companyName: client.name,
                  ownerName: client.contactName,
                  address: client.address,
                  city: client.city,
                  state: client.state,
                  zip: client.zip.toString(),
                  country: client.country,
                  phone: client.phone,
                  email: client.email,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                BuildInvoiceHighlightsItem(
                  title: 'invoice number:',
                  value: invoice.number.toString(),
                ),
                SizedBox(height: 2.spa),
                BuildInvoiceHighlightsItem(
                  title: 'invoice date:',
                  value: InvoiceHelper.fromDateToYMD(invoice.createdAt),
                ),
                SizedBox(height: 2.spa),
                BuildInvoiceHighlightsItem(
                  title: 'due date:',
                  value: invoice.dueDate,
                ),
                SizedBox(height: 2.spa),
                Container(
                  padding: EdgeInsets.all(1.0.spa),
                  color: Colors.black12,
                  child: BuildInvoiceHighlightsItem(
                    isAmount: true,
                    title: 'amount due (${invoice.currency ?? 'USD'}):',
                    value: (invoice.currencySymbol ?? '\$') +
                        InvoiceHelper.calculateInvoiceTotal(
                          invoice,
                        ).toString(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
