-- ============================================================
-- Usaha OS — Supabase Schema (Phase 1 & Phase 2)
-- Run this in your Supabase SQL Editor (Dashboard → SQL Editor)
-- ============================================================

-- ── PHASE 1 TABLES ──────────────────────────────────────────

-- Categories
CREATE TABLE IF NOT EXISTS categories (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  icon_code TEXT DEFAULT 'e532',
  color_hex TEXT DEFAULT '#C17F3A',
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Menu Items
CREATE TABLE IF NOT EXISTS menu_items (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  category_id BIGINT REFERENCES categories(id) ON DELETE SET NULL,
  name TEXT NOT NULL,
  description TEXT DEFAULT '',
  base_price REAL NOT NULL,
  image_url TEXT,
  is_available BOOLEAN DEFAULT TRUE,
  preparation_station TEXT DEFAULT 'kitchen',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Ingredients
CREATE TABLE IF NOT EXISTS ingredients (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  unit TEXT NOT NULL,
  current_stock REAL DEFAULT 0,
  reorder_point REAL DEFAULT 0,
  cost_per_unit REAL DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Menu Item Ingredients (Bill of Materials)
CREATE TABLE IF NOT EXISTS menu_item_ingredients (
  menu_item_id BIGINT REFERENCES menu_items(id) ON DELETE CASCADE,
  ingredient_id BIGINT REFERENCES ingredients(id) ON DELETE CASCADE,
  quantity_required REAL NOT NULL,
  PRIMARY KEY (menu_item_id, ingredient_id)
);

-- Orders
CREATE TABLE IF NOT EXISTS orders (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  order_number TEXT NOT NULL,
  order_type TEXT DEFAULT 'takeaway',   -- dine_in | takeaway | delivery
  table_number INT,
  status TEXT DEFAULT 'pending',        -- pending | in_progress | ready | completed | voided
  created_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  subtotal REAL DEFAULT 0,
  tax_amount REAL DEFAULT 0,
  total_amount REAL DEFAULT 0,
  payment_method TEXT,                  -- cash | duitnow_qr | card
  tendered_amount REAL,
  notes TEXT DEFAULT ''
);

-- Order Items
CREATE TABLE IF NOT EXISTS order_items (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  order_id BIGINT REFERENCES orders(id) ON DELETE CASCADE,
  menu_item_id BIGINT REFERENCES menu_items(id) ON DELETE SET NULL,
  item_name TEXT NOT NULL,
  quantity INT NOT NULL,
  unit_price REAL NOT NULL,
  subtotal REAL NOT NULL,
  modifiers TEXT DEFAULT ''
);

-- ── PHASE 2 TABLES ──────────────────────────────────────────

-- Tasks (Daily Operations, Checklists, Handover Notes)
CREATE TABLE IF NOT EXISTS tasks (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT DEFAULT '',
  category TEXT DEFAULT 'opening',       -- opening | closing | cleaning | maintenance | handover | general
  assigned_to TEXT,
  status TEXT DEFAULT 'todo',           -- todo | in_progress | completed
  priority TEXT DEFAULT 'medium',       -- low | medium | high
  due_date TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  completed_by TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Customers & Members (CRM / Loyalty)
CREATE TABLE IF NOT EXISTS customers (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL UNIQUE,
  email TEXT,
  points INT DEFAULT 0,
  tier TEXT DEFAULT 'Bronze',           -- Bronze | Silver | Gold | Platinum
  total_spent REAL DEFAULT 0,
  stamps_count INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  last_visited_at TIMESTAMPTZ
);

-- Staff Members
CREATE TABLE IF NOT EXISTS staff_members (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  role TEXT DEFAULT 'Cashier',          -- Cashier | Barista | Kitchen Staff | Shift Manager | Owner
  pin_code TEXT DEFAULT '1234',
  phone TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  hourly_rate REAL DEFAULT 10.0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Staff Attendance & Shift Logs
CREATE TABLE IF NOT EXISTS staff_attendances (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  staff_id BIGINT REFERENCES staff_members(id) ON DELETE CASCADE,
  staff_name TEXT NOT NULL,
  clock_in_time TIMESTAMPTZ DEFAULT NOW(),
  clock_out_time TIMESTAMPTZ,
  total_minutes INT DEFAULT 0,
  notes TEXT DEFAULT '',
  date TEXT NOT NULL
);

-- ── Enable Realtime on all tables ──────────────────────────────────
ALTER PUBLICATION supabase_realtime ADD TABLE categories;
ALTER PUBLICATION supabase_realtime ADD TABLE menu_items;
ALTER PUBLICATION supabase_realtime ADD TABLE ingredients;
ALTER PUBLICATION supabase_realtime ADD TABLE orders;
ALTER PUBLICATION supabase_realtime ADD TABLE order_items;
ALTER PUBLICATION supabase_realtime ADD TABLE tasks;
ALTER PUBLICATION supabase_realtime ADD TABLE customers;
ALTER PUBLICATION supabase_realtime ADD TABLE staff_members;
ALTER PUBLICATION supabase_realtime ADD TABLE staff_attendances;

-- ── Enable FULL Replica Identity for complete DELETE payloads ──────
ALTER TABLE categories REPLICA IDENTITY FULL;
ALTER TABLE menu_items REPLICA IDENTITY FULL;
ALTER TABLE ingredients REPLICA IDENTITY FULL;
ALTER TABLE orders REPLICA IDENTITY FULL;
ALTER TABLE order_items REPLICA IDENTITY FULL;
ALTER TABLE tasks REPLICA IDENTITY FULL;
ALTER TABLE customers REPLICA IDENTITY FULL;
ALTER TABLE staff_members REPLICA IDENTITY FULL;
ALTER TABLE staff_attendances REPLICA IDENTITY FULL;

-- ── Row Level Security (open for dev; tighten for production) ─────
CREATE POLICY "allow_all" ON categories FOR ALL USING (true);
CREATE POLICY "allow_all" ON menu_items FOR ALL USING (true);
CREATE POLICY "allow_all" ON ingredients FOR ALL USING (true);
CREATE POLICY "allow_all" ON menu_item_ingredients FOR ALL USING (true);
CREATE POLICY "allow_all" ON orders FOR ALL USING (true);
CREATE POLICY "allow_all" ON order_items FOR ALL USING (true);
CREATE POLICY "allow_all" ON tasks FOR ALL USING (true);
CREATE POLICY "allow_all" ON customers FOR ALL USING (true);
CREATE POLICY "allow_all" ON staff_members FOR ALL USING (true);
CREATE POLICY "allow_all" ON staff_attendances FOR ALL USING (true);
