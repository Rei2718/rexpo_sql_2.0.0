1. Reset local DB
npx supabase stop --no-backup
npx supabase start

2. Combine files
Remove-Item supabase/migrations/*.sql

$ts = Get-Date -Format "yyyyMMddHHmmss"
$migrationFile = "supabase/migrations/${ts}_init_schema.sql"

Get-Content `
  function/update_at.sql, `
  table/venues.sql, `
  table/organizations.sql, `
  table/tags.sql, `
  table/slots.sql, `
  table/performers.sql, `
  table/categories.sql, `
  table/foods.sql, `
  table/events.sql, `
  table/features.sql, `
  table/banners.sql, `
  table/news.sql, `
  middle/*.sql, `
  mv/*.sql, `
  function/refresh-all-mvs.sql, `
  rpc/*.sql, `
  function/triggers-refresh-mv.sql `
  | Set-Content $migrationFile -Encoding UTF8
  
3. Prepare seed data
Copy-Item supabase/seed-test.sql supabase/seed.sql

4. DB reset (migrate & seed)
npx supabase db reset

5. Update MV
SELECT refresh_all_mvs();