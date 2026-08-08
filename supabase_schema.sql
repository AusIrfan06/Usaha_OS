-- ============================================================
-- Usaha OS — Supabase Schema
-- Run this in your Supabase SQL Editor (Dashboard → SQL Editor)
-- ============================================================

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

-- ── Enable Realtime on tables ──────────────────────────────────────
ALTER PUBLICATION supabase_realtime ADD TABLE categories;
ALTER PUBLICATION supabase_realtime ADD TABLE menu_items;
ALTER PUBLICATION supabase_realtime ADD TABLE ingredients;
ALTER PUBLICATION supabase_realtime ADD TABLE orders;
ALTER PUBLICATION supabase_realtime ADD TABLE order_items;

-- ── Enable FULL Replica Identity for complete DELETE payloads ──────
ALTER TABLE categories REPLICA IDENTITY FULL;
ALTER TABLE menu_items REPLICA IDENTITY FULL;
ALTER TABLE ingredients REPLICA IDENTITY FULL;
ALTER TABLE orders REPLICA IDENTITY FULL;
ALTER TABLE order_items REPLICA IDENTITY FULL;

-- ── Row Level Security (open for dev; tighten for production) ─────
-- For development: allow all
CREATE POLICY "allow_all" ON categories FOR ALL USING (true);
CREATE POLICY "allow_all" ON menu_items FOR ALL USING (true);
CREATE POLICY "allow_all" ON ingredients FOR ALL USING (true);
CREATE POLICY "allow_all" ON menu_item_ingredients FOR ALL USING (true);
CREATE POLICY "allow_all" ON orders FOR ALL USING (true);
CREATE POLICY "allow_all" ON order_items FOR ALL USING (true);

