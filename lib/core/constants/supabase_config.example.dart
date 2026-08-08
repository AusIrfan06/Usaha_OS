/// ⚠️ Template for Supabase project credentials.
/// Copy this file to `supabase_config.dart` and fill in your actual credentials.
/// Found in: Supabase Dashboard → Settings → API
class SupabaseConfig {
  SupabaseConfig._();

  /// Your Supabase project URL.
  /// Example: https://abcdefghijklmn.supabase.co
  static const String url = 'YOUR_SUPABASE_URL';

  /// Your Supabase anon/public key.
  static const String anonKey = 'YOUR_SUPABASE_ANON_KEY';

  /// Returns true when real credentials have been provided.
  static bool get isConfigured =>
      !url.contains('YOUR_') && !anonKey.contains('YOUR_');
}
