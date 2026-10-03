# Power Platform Custom Connector — Finance Invoice API

![Custom Connector](https://img.shields.io/badge/Custom%20Connector-OpenAPI%202.0-6C757D?style=flat-square)
![Power Apps](https://img.shields.io/badge/Power%20Apps-742774?style=flat-square)
![Power Automate](https://img.shields.io/badge/Power%20Automate-0066FF?style=flat-square)

A custom connector that exposes an internal REST API to Power Apps and Power Automate, so users stop **re-keying data by hand** between systems.

> Demo connector against a fictional Invoice API. It mirrors the approach I used to connect a finance team to an internal system; the real API and data are not included.

## 🎯 Problem → Solution

| Before | After |
|---|---|
| Finance staff copied invoice data from an internal system into SharePoint by hand | A custom connector reads and writes invoices directly from Power Apps and flows |
| Typos and delays | Validated data, available instantly |

## 🔌 Operations

| Operation ID | Method | Path | Purpose |
|---|---|---|---|
| `GetInvoices` | GET | `/invoices` | List invoices, filter by status |
| `GetInvoiceById` | GET | `/invoices/{invoiceId}` | Get one invoice |
| `CreateInvoice` | POST | `/invoices` | Create an invoice |
| `UpdateInvoiceStatus` | PATCH | `/invoices/{invoiceId}/status` | Approve / reject |

Authentication: **API key** in the `x-api-key` header.

## 📁 Structure

```
├── connector/
│   ├── apiDefinition.swagger.json   # OpenAPI 2.0 definition
│   └── apiProperties.json           # Connection parameters, branding
└── powerfx/
    └── usage-examples.fx            # Calling the connector from a canvas app
```

## 🚀 Deploy with Power Platform CLI

```bash
pac auth create --environment https://<your-env>.crm.dynamics.com
pac connector create \
  --api-definition-file connector/apiDefinition.swagger.json \
  --api-properties-file connector/apiProperties.json \
  --solution-unique-name FinanceIntegration
```

Or import the swagger file manually: **make.powerapps.com → Custom connectors → New → Import an OpenAPI file**.

## ✅ Best practices applied

- Every operation has `summary`, `description` and `x-ms-summary` so it reads clearly in the designer
- Response schemas defined, so Power Fx gets typed fields (no `ParseJSON` needed)
- Connector added to a **solution** and promoted with environment-specific hosts
- Secrets stored in the connection, never in the app

## 👤 Author

**Pavan Reddy Cheedeti** — Power Platform Developer · [LinkedIn](https://www.linkedin.com/in/pavan-reddy-ch-a960b7439/)
