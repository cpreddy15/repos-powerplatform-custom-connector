// Connector added to the app as "FinanceInvoiceAPI"

// --- galInvoices.Items ----------------------------------------------
FinanceInvoiceAPI.GetInvoices({ status: ddStatus.Selected.Value, top: 100 }).value

// --- btnCreate.OnSelect ---------------------------------------------
Set(
    varCreated,
    FinanceInvoiceAPI.CreateInvoice(
        {
            vendorName: txtVendor.Text,
            amount: Value(txtAmount.Text),
            currency: ddCurrency.Selected.Value,
            invoiceDate: Text(dpInvoiceDate.SelectedDate, "yyyy-mm-dd")
        }
    )
);
Notify("Invoice " & varCreated.invoiceId & " created.", NotificationType.Success);

// --- btnApprove.OnSelect --------------------------------------------
IfError(
    FinanceInvoiceAPI.UpdateInvoiceStatus(
        galInvoices.Selected.invoiceId,
        { status: "Approved", comment: txtComment.Text }
    );
    Notify("Approved.", NotificationType.Success),
    Notify("Update failed: " & FirstError.Message, NotificationType.Error)
);
