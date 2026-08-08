# Usaha OS — Malaysia POS System Blueprint
### "Usaha OS" — A Complete, Regulation-Ready, Multi-Device Point-of-Sale Ecosystem

---

## 1. Vision & Design Principles

A POS built as the **operational nerve center** of the cafe, not just a cash register:

| Principle | What it means |
|---|---|
| **Compliance-first** | LHDN e-Invoice, SST, and receipt law are built into the core, not bolted on |
| **Offline-first, cloud-synced** | Never stops selling even if the internet drops; syncs the moment it's back |
| **One brain, many screens** | Cashier tablet, kitchen display, customer display, manager's phone, back-office laptop — all live views of the same real-time data |
| **Multitasking by design** | Staff can hold an order, jump to another table, process a refund, and check stock — without losing context |
| **Modern, adaptive UI** | Same design system scales from a 5" handheld to a 24" counter touchscreen to a wall-mounted KDS |
| **Ecosystem-ready** | Printers, scanners, cash drawers, payment terminals, scales, and third-party delivery apps all plug into one hub |

---

## 2. System Architecture (High Level) — Single Flutter Codebase

Building everything in **Flutter** is the right call here — one codebase compiles natively to Android tablets, iOS/iPad, Windows (counter PCs), macOS, Linux, and Web. That means the cashier POS, KDS, customer display, manager app, and owner dashboard are all the *same app*, just with different role-based layouts/routes — not five separate builds to maintain.

```
                         ┌───────────────────────────────────┐
                         │      CLOUD BACKEND (SG/MY         │
                         │   data center — PDPA compliant)   │
                         │  • Central database (orders,      │
                         │    menu, live stock, staff,       │
                         │    tasks)                         │
                         │  • SST tax engine (F&B 6%)        │
                         │  • Analytics & reporting engine   │
                         │  • Multi-outlet sync layer        │
                         │  (e-Invoice/MyInvois module:      │
                         │   built-in but OFF by default —   │
                         │   flip on later if you cross      │
                         │   RM1M turnover)                  │
                         └───────────────┬───────────────────┘
                                         │ (real-time sync, WebSocket/Firestore-style + REST)
        ┌────────────────┬─────────────┼─────────────┬────────────────┐
        │                │             │             │                │
 ┌──────▼──────┐  ┌──────▼──────┐ ┌────▼─────┐ ┌─────▼──────┐ ┌───────▼────────┐
 │ Cashier POS │  │ Kitchen     │ │Customer  │ │ Manager App│ │ Owner Dashboard│
 │ (Flutter —  │  │ Display     │ │Display / │ │ (Flutter — │ │ (Flutter Web/  │
 │ Android/iPad│  │ (Flutter,   │ │Self-order│ │ phone)     │ │ Windows/macOS) │
 │ /Windows)   │  │ same app)   │ │(Flutter) │ │            │ │                │
 └──────┬──────┘  └─────────────┘ └──────────┘ └────────────┘ └────────────────┘
        │              ▲ all built from ONE Flutter codebase, role/screen-size aware ▲
        │
        │ Local SQLite (via drift/sqflite) — offline cache, keeps selling if WiFi drops
        │
 ┌──────▼───────────────────────────────────────────────────────┐
 │ HARDWARE ECOSYSTEM LAYER (Bluetooth/USB/LAN plugins)         │
 │ Receipt printer • Cash drawer • Barcode/QR scanner •         │
 │ Card/DuitNow QR terminal • Kitchen printer • Customer display│
 │ • Weighing scale (for bakery/by-weight items)                │
 └──────────────────────────────────────────────────────────────┘
```

**Key architectural decisions:**
- **Offline-first with local caching.** Malaysian cafes — especially in malls, shoplots, or areas with patchy fiber — cannot afford to stop selling because the router hiccuped. Every device holds a local SQLite copy of menu/pricing/live stock and queues transactions for sync via a background worker.
- **One codebase, adaptive UI.** Flutter's `LayoutBuilder`/responsive breakpoints drive completely different visual layouts (see Section 6) from the same shared business logic and state (Riverpod/Bloc), so you're not duplicating order/stock/task logic per device.
- **e-Invoice module built but dormant.** Since you're not required to comply yet, the MyInvois integration ships as a disabled feature flag — zero extra taps for your cashiers today, and a same-day switch-on later if your turnover grows past the RM1 million threshold.

---

## 3. Malaysia Regulatory Compliance Module

This is the part most generic (US/Euro-built) POS systems get wrong. Build it as a dedicated compliance layer:

### 3.1 LHDN e-Invoice (MyInvois) — Built-in, Switched OFF for now
Not needed at your current scale (exemption applies under RM1 million annual turnover), so this stays as a **dormant module** — invisible to your cashiers, zero workflow impact. Kept in the architecture so you're not rebuilding from scratch if you scale past the threshold later. What it does when eventually switched on:
- Direct **API integration with MyInvois** (not manual portal entry) — every transaction auto-generates and validates the required data fields (buyer/seller TIN, SST reg no., classification codes, line items, totals).
- **Consolidated e-Invoice mode**: since most walk-in cafe sales are B2C and small-value, support monthly consolidated e-Invoices (permitted during the relaxation period) instead of per-transaction submission — much lighter on cashier workflow.
- **Individual e-Invoice trigger**: any single transaction above RM10,000 (corporate catering orders, events) auto-flags for individual e-Invoice generation with buyer TIN capture at checkout.
- **B2B mode**: when a corporate customer requests a proper e-Invoice (e.g. office catering), cashier can capture buyer TIN/business details on the spot and issue instantly.
- **Threshold toggle**: since the mandate applies once your turnover passes RM1 million/year, the system tracks rolling 12-month revenue and proactively alerts you *before* you cross into mandatory territory — with a "compliance readiness" checklist.
- Digital signature handling and IRBM certificate management built into settings — not something the cashier ever touches.

### 3.2 SST (Sales & Service Tax) Engine
- F&B service tax pre-configured at **6%**, applied only once your registered service revenue crosses the **RM1.5 million/year** threshold specific to F&B (higher than the general RM500k threshold).
- Tax engine supports mixed carts — e.g. food/beverage at 6% service tax vs. retail merchandise (mugs, beans, pastry boxes) that may fall under different Sales Tax treatment.
- Auto-generates SST-02 bi-monthly filing reports (exportable for your accountant or the MySST portal).
- Clear SST line-item breakdown printed on every receipt (rate + amount), as required.

### 3.3 Receipt & Record-Keeping Compliance
- Digital + printed receipt with all statutory fields: business name, SSM registration no., SST reg no. (if applicable), TIN, itemized list, tax breakdown, payment method, QR code linking to the e-Invoice (once applicable).
- 7-year record retention (Income Tax Act requirement) — cloud storage with audit trail, tamper-evident transaction logs.
- **PDPA (Personal Data Protection Act)** compliant handling of customer data collected via loyalty/CRM — explicit consent capture, right-to-delete workflow.

### 3.4 Payments Native to Malaysia
- **DuitNow QR** (unified national QR — works with all local banks and e-wallets in one scan)
- Touch 'n Go eWallet, GrabPay, Boost, ShopeePay
- FPX (bank transfer) for larger B2B invoices
- Visa/Mastercard via integrated EDC terminal
- Cash with auto cash-drawer trigger and change calculation
- Split payment (e.g. half cash, half e-wallet) and split-bill by item or by person

---

## 4. Core Operational Modules

### A. Order & Sales (Front of House)
- Grid or list menu view with modifiers (size, sugar level, add-ons — essential for kopitiam/cafe culture)
- Table management (dine-in), takeaway, delivery channel tagging (GrabFood/Foodpanda/ShopeeFood integration)
- Order hold/park, merge tables, split bills, item-level discounts, promo codes, birthday/member pricing
- Quick-serve mode (counter cafes) vs. full-service mode (table service with course firing)

### B. Kitchen Display System (KDS)
- Orders route by station (drinks bar vs. kitchen vs. pastry) automatically
- Color-coded aging timers (green → amber → red) so nothing gets forgotten
- Bump/recall, "all-day view" for the whole kitchen to see volume at a glance
- Optional bell/chime + printed kitchen docket as backup

### C. Live Stock Management (Real-Time Inventory)
This runs continuously in the background, not as a once-a-day check:
- **Real-time deduction**: every sale instantly deducts ingredient-level stock via the recipe/BOM (Bill of Materials) — sell one Cappuccino → auto-deducts milk (ml), coffee beans (g), cup, lid from live stock, no manual entry.
- **Live stock dashboard**: owner/manager sees current stock levels for every ingredient and finished good, updating in real time across every device — no more "let me go check the storeroom."
- **Two-way sync across outlets**: if you open a second branch, central stock view shows all locations side by side.
- **Low-stock & out-of-stock alerts**: push notification the moment an item crosses its reorder point (e.g. "Fresh milk: 2L left — reorder now"), plus auto-hide/86 a menu item from the ordering screen when a required ingredient hits zero, so cashiers can't sell what the kitchen can't make.
- **Stock take / physical count mode**: guided counting screen (by category/section) to reconcile system stock vs. actual shelf stock, with variance report (flags shrinkage, wastage, or entry errors).
- **Wastage & spoilage logging**: quick-log spoiled/expired items with reason codes (expired, dropped, wrong order) — feeds directly into cost reporting so wastage isn't invisible.
- **Supplier & purchase order management**: supplier contact list, reorder point per ingredient, one-tap "generate PO" from the low-stock alert, PO status tracking (ordered → received).
- **Batch & expiry tracking**: especially for milk, pastries, syrups — FEFO (first-expiry-first-out) prompts so nothing quietly expires in the back.
- **Multi-unit conversion**: kg↔g, L↔ml, handled automatically so recipe costing and purchasing units don't have to match 1:1.
- **Ingredient-level cost tracking**: live COGS per item as ingredient prices change (e.g. coffee bean price spike updates margin calculations automatically).

### D. Task Management (Daily Operations)
Turns the POS into the cafe's shift-running tool, not just a checkout:
- **Opening & closing checklists**: digital checklist staff must tick through at shift start/end (fridge temp check, float count, machine clean, lights/signage) — timestamped and logged for accountability.
- **Recurring task scheduler**: daily/weekly/monthly cleaning and maintenance tasks (deep-clean espresso machine, defrost freezer, pest control check) auto-assigned to shifts.
- **Ad-hoc task assignment**: manager assigns a one-off task to a specific staff member from their phone ("restock napkins at counter 2") with due time and completion tracking.
- **Shift handover notes**: outgoing shift leaves notes for the incoming shift (e.g. "milk delivery didn't come, follow up," "table 5 had a complaint") — visible right on login.
- **Task status board**: Kanban-style (To Do / In Progress / Done) visible to managers across all devices, so nothing falls through the cracks during a busy shift.
- **Completion accountability**: every task tied to a staff login — who did it and when, useful for audits and performance reviews.

### E. Other Essential Store Functions
- **Expense tracking**: log day-to-day operating expenses (utilities, small purchases, repairs) against categories, feeding into overall P&L alongside sales.
- **Cash management**: float/drawer count at open and close, over/short reconciliation, cash-out for petty expenses tracked against the drawer.
- **Incident/maintenance log**: record equipment faults (e.g. "espresso machine group 2 leaking"), complaint logs, and follow-up status — useful history when calling a technician or reviewing recurring issues.
- **Recipe/menu builder**: drag-and-drop recipe costing tool — build a menu item, attach ingredients with quantities, system auto-calculates cost price and suggested margin.
- **Promotions & discount engine**: time-based promos (happy hour), combo/bundle pricing, staff-meal comping with approval trail.
- **Multi-language support**: Bahasa Malaysia, English, and Chinese toggle for both staff-facing and customer-facing screens — reflects real Malaysian cafe staffing and customer base.
- **Audit trail**: every void, discount, refund, and stock adjustment is logged with who/when/why — protects you and gives clean data if you ever need to investigate a discrepancy.

### F. CRM & Loyalty
- Member sign-up via phone number/QR (integrates with WhatsApp for receipts/promos — huge in Malaysia)
- Points, stamp cards (buy-9-get-1-free style), tiered membership
- Push promos to slow hours (e.g. 3–5pm lull) via SMS/WhatsApp/app notification
- Birthday and win-back campaigns

### G. Staff & HR
- Role-based access (cashier, barista, kitchen, shift manager, owner)
- Clock-in/out with facial or PIN verification
- Shift scheduling, tip pooling, commission tracking
- Permission-gated actions (voids, discounts, refunds require manager PIN)

### H. Multi-Outlet & Franchise Ready
- Central menu/pricing push to all branches, with per-branch override (e.g. one outlet in a mall pays higher rent-adjusted pricing)
- Cross-branch inventory transfer
- Consolidated reporting across all outlets, drill down to single branch

### I. Reporting & Analytics
- Real-time sales dashboard (today vs. yesterday vs. last week)
- Best-sellers, slow-movers, hourly heatmap (know your 8am rush vs. 3pm lull)
- Cost of Goods Sold (COGS) and margin per item
- Staff performance, average ticket size, table turnover time
- Exportable P&L-ready reports for your accountant

---

## 5. Multitasking & Workflow Design

The cashier screen is built around **parallel task handling**, not a rigid single-screen flow:

- **Order queue sidebar** — always visible, lets staff jump between 5 open orders without losing any of them
- **Floating action bar** — refund, void, reprint receipt, open drawer accessible from anywhere without navigating away from the current sale
- **Background sync indicator** — subtle status dot shows sync/print/payment status without blocking the next action
- **Split-screen on tablets** — e.g. order-taking on the left, live KDS status on the right, so front-of-house can glance at kitchen progress
- **Gesture shortcuts** — swipe to hold an order, long-press to apply a quick discount, drag-to-merge tables

---

## 6. Modern, Adaptive UI/UX

One design system, multiple responsive layouts:

| Device | Layout behavior |
|---|---|
| **Phone (owner/manager)** | Single-column dashboard cards, swipeable reports, push notifications for anomalies (e.g. large void, cash drawer opened after hours) |
| **Tablet (cashier, 10–13")** | Two-pane: menu grid + live cart, large touch targets (min 44px), high-contrast for busy counter lighting |
| **Large touchscreen (counter kiosk/self-order, 21–24")** | Big visual menu cards with photos, ideal for self-service ordering kiosks |
| **Kitchen Display (wall-mounted, 15–22", often landscape, viewed from a distance)** | Extra-large text, minimal color palette (status-driven: white/amber/red), no fine print |
| **Customer-facing display (small screen, mirrored counter unit)** | Order summary, total, QR for e-payment, promo banner |
| **Laptop/Desktop (back office)** | Dense data tables, multi-column reports, drag-and-drop menu builder |

Design language: clean, warm neutral palette echoing a cafe environment, rounded cards, subtle motion for order state changes (no jarring transitions), dark-mode option for late-night bakery prep or dim ambient cafes.

---

## 7. Ecosystem & Device Sync

- **Real-time sync** across every device the moment an order is placed — kitchen sees it instantly, owner's phone dashboard updates live
- **Peripheral ecosystem**: thermal receipt printers, kitchen dot-matrix/thermal printers, cash drawers (RJ11 trigger), barcode/QR scanners, weighing scales (bakery/bulk coffee beans), customer-facing pole displays
- **Third-party integrations**: accounting software (e.g. SQL Account, AutoCount — popular in Malaysia), delivery platforms (GrabFood, Foodpanda, ShopeeFood order injection directly into KDS so riders' orders don't need manual re-entry), WhatsApp Business API for e-receipts and marketing
- **Cross-platform apps**: iOS/Android for mobile devices, web-based dashboard for any browser, optional native Windows/Android app for dedicated POS terminals

---

## 8. Suggested Tech Stack (Flutter-First, for a dev team or vendor brief)

| Layer | Suggestion |
|---|---|
| Frontend (all devices) | **Flutter** — single codebase for POS tablet, KDS, customer display, manager phone app, and owner dashboard (Android, iOS, Windows, macOS, Web all from one project) |
| State management | Riverpod or Bloc — keeps order/stock/task state consistent and testable across every screen size |
| Local offline DB | **Drift** (SQLite wrapper for Flutter) or `sqflite` — per-device local cache, syncs to cloud when online |
| Responsive layer | Flutter's `LayoutBuilder`/`MediaQuery` breakpoints + a shared design-token package, so phone/tablet/KDS/kiosk all pull from one design system (see Section 6) |
| Backend | Node.js, Go, or **Firebase/Supabase** (both pair naturally with Flutter for real-time sync + auth, and can shortcut a lot of the WebSocket/live-stock plumbing) |
| Database (cloud) | PostgreSQL (via Supabase) or Firestore — either works well with Flutter's real-time listeners for live stock/task updates |
| Hosting | Hosted in **Asia Pacific (Singapore) region** for latency + data residency comfort |
| Payment gateway | Local aggregator supporting DuitNow QR + e-wallets (e.g. iPay88, Billplz, Curlec/Razorpay MY) — most offer Flutter/REST SDKs |
| Printer/hardware plugins | Flutter packages like `esc_pos_printer`/`flutter_esc_pos_utils` for thermal printers, `flutter_blue_plus` for Bluetooth peripherals (scanners, scales, cash drawers) |
| Notifications | Firebase Cloud Messaging (native Flutter support) + WhatsApp Business API for customer-facing receipts/promos |
| e-Invoice | Kept as a disabled module (see 3.1) — not built into MVP scope |

---

## 9. Suggested Rollout Roadmap

| Phase | Focus |
|---|---|
| **Phase 1 (MVP)** | Core POS: order-taking, payment (cash + DuitNow QR + cards), receipt printing, **live stock deduction on sale**, basic reporting — single outlet, on Flutter with offline-first local DB |
| **Phase 2** | KDS, **task management (checklists, shift handover)**, CRM/loyalty, staff clock-in/scheduling, offline mode hardening |
| **Phase 3** | SST engine (F&B 6%), stock take/variance tools, supplier & PO management, expense/cash management, PDPA-safe data handling |
| **Phase 4** | Multi-outlet sync, delivery platform integrations (GrabFood/Foodpanda/ShopeeFood), advanced analytics |
| **Phase 5** | Self-order kiosk mode, customer-facing app, AI-driven demand forecasting/reorder suggestions, **e-Invoice module switched on** — only if/when turnover crosses RM1 million |

---

## 10. Practical Notes for You as Owner

- **e-Invoice is correctly out of scope for now.** Skipping it keeps your MVP leaner and your cashier workflow faster — the module stays designed-for but dormant, so switching it on later (if you cross RM1M turnover) is a config change, not a rebuild.
- **SST still applies once you cross RM1.5M in F&B service revenue** — worth keeping that engine in Phase 3 even though e-Invoice is skipped; they're separate obligations.
- **Live stock is worth building early, not later.** It's the module that saves the most real money (catching wastage, stopping overselling out-of-stock items, avoiding last-minute supply runs) — prioritized into Phase 1/2 above rather than treated as a "nice to have."
- **Flutter is a strong choice** for exactly the reason you gave — one team, one codebase, genuinely native performance on tablets/Windows counters, and you're not paying to build/maintain separate iOS, Android, and desktop apps.
- **DuitNow QR should be your default digital payment**, not card terminals — lower merchant fees, near-universal adoption in Malaysia.
- **WhatsApp > SMS** for receipts and promos here — far higher open rates locally.
- **Buy vs. build**: existing Malaysian POS platforms (StoreHub, Loyverse, iSAP, Slurp, Eezee, Fungsi) already cover much of Sections 3–7. This blueprint is equally useful as a **requirements checklist to evaluate vendors against**, or as a spec if you're commissioning custom Flutter development.

---

*This is a planning blueprint, not tax or legal advice — confirm your specific SST/e-Invoice obligations with a licensed tax agent or via the official MySST (mysst.customs.gov.my) and MyInvois portals, since thresholds have shifted more than once in the past year.*
