-- Ejecutar completo en Supabase > SQL Editor.
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null check (role in ('owner', 'entrepreneur')),
  full_name text not null,
  email text not null,
  phone text,
  account_type text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.spaces (
  id text primary key,
  owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  location text not null,
  description text,
  price numeric not null default 0,
  unit text not null default '/día',
  furnishing text,
  image text,
  latitude double precision,
  longitude double precision,
  status text not null default 'available',
  created_at timestamptz not null default now()
);

alter table public.spaces add column if not exists metadata jsonb not null default '{}'::jsonb;
alter table public.spaces add column if not exists reserved_from date;
alter table public.spaces add column if not exists reserved_until date;

create table if not exists public.reservations (
  id text primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  owner_id uuid references auth.users(id) on delete set null,
  space_id text not null references public.spaces(id) on delete cascade,
  quantity integer not null default 1,
  unit text not null,
  total numeric not null default 0,
  status text not null default 'requested',
  created_at timestamptz not null default now()
);

alter table public.reservations add column if not exists start_date date;
alter table public.reservations add column if not exists end_date date;

create table if not exists public.space_follows (
  user_id uuid not null references auth.users(id) on delete cascade,
  space_id text not null references public.spaces(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, space_id)
);

create table if not exists public.space_offers (
  id text primary key,
  space_id text not null references public.spaces(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  owner_id uuid not null references auth.users(id) on delete cascade,
  amount numeric not null default 0,
  unit text not null default '/día',
  proposed_start date,
  message text,
  status text not null default 'pending' check (status in ('pending','accepted','rejected','withdrawn')),
  created_at timestamptz not null default now()
);

create table if not exists public.retention_offers (
  id text primary key,
  space_id text not null references public.spaces(id) on delete cascade,
  reservation_id text references public.reservations(id) on delete set null,
  owner_id uuid not null references auth.users(id) on delete cascade,
  entrepreneur_id uuid not null references auth.users(id) on delete cascade,
  term_months integer not null check (term_months > 0),
  monthly_price numeric not null default 0,
  discount_percent numeric not null default 0,
  benefits text[] not null default '{}',
  message text,
  status text not null default 'pending' check (status in ('pending','accepted','rejected','expired')),
  expires_at timestamptz,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.spaces enable row level security;
alter table public.reservations enable row level security;
alter table public.space_follows enable row level security;
alter table public.space_offers enable row level security;
alter table public.retention_offers enable row level security;

grant select, insert, update on public.profiles to authenticated;
grant select, insert, update on public.spaces to authenticated;
grant select on public.spaces to anon;
grant select, insert, update on public.reservations to authenticated;
grant select, insert, delete on public.space_follows to authenticated;
grant select, insert, update on public.space_offers to authenticated;
grant select, insert, update on public.retention_offers to authenticated;

drop policy if exists "Users can read their profile" on public.profiles;
create policy "Users can read their profile" on public.profiles for select to authenticated using ((select auth.uid()) = id);
drop policy if exists "Users can create their profile" on public.profiles;
create policy "Users can create their profile" on public.profiles for insert to authenticated with check ((select auth.uid()) = id);
drop policy if exists "Users can update their profile" on public.profiles;
create policy "Users can update their profile" on public.profiles for update to authenticated using ((select auth.uid()) = id) with check ((select auth.uid()) = id);

drop policy if exists "Anyone authenticated can read spaces" on public.spaces;
create policy "Anyone authenticated can read spaces" on public.spaces for select to authenticated using (true);
drop policy if exists "Public can read available spaces" on public.spaces;
create policy "Public can read available spaces" on public.spaces for select to anon using (status = 'available');
drop policy if exists "Owners can create spaces" on public.spaces;
create policy "Owners can create spaces" on public.spaces for insert to authenticated with check ((select auth.uid()) = owner_id);
drop policy if exists "Owners can update spaces" on public.spaces;
create policy "Owners can update spaces" on public.spaces for update to authenticated using ((select auth.uid()) = owner_id) with check ((select auth.uid()) = owner_id);

do $$ begin
  alter publication supabase_realtime add table public.spaces;
exception when duplicate_object then null;
end $$;

drop policy if exists "Users can read their reservations" on public.reservations;
create policy "Users can read their reservations" on public.reservations for select to authenticated using ((select auth.uid()) = user_id or (select auth.uid()) = owner_id);
drop policy if exists "Entrepreneurs can create reservations" on public.reservations;
create policy "Entrepreneurs can create reservations" on public.reservations for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "Users can update their reservations" on public.reservations;
create policy "Users can update their reservations" on public.reservations for update to authenticated using ((select auth.uid()) = user_id or (select auth.uid()) = owner_id) with check ((select auth.uid()) = user_id or (select auth.uid()) = owner_id);

drop policy if exists "Users can follow spaces" on public.space_follows;
create policy "Users can follow spaces" on public.space_follows for all to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "Users can create offers" on public.space_offers;
create policy "Users can create offers" on public.space_offers for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "Users and owners can read offers" on public.space_offers;
create policy "Users and owners can read offers" on public.space_offers for select to authenticated using ((select auth.uid()) = user_id or (select auth.uid()) = owner_id);
drop policy if exists "Owners can update offers" on public.space_offers;
create policy "Owners can update offers" on public.space_offers for update to authenticated using ((select auth.uid()) = owner_id) with check ((select auth.uid()) = owner_id);

drop policy if exists "Owners can create retention offers" on public.retention_offers;
create policy "Owners can create retention offers" on public.retention_offers for insert to authenticated with check ((select auth.uid()) = owner_id);
drop policy if exists "Participants can read retention offers" on public.retention_offers;
create policy "Participants can read retention offers" on public.retention_offers for select to authenticated using ((select auth.uid()) = owner_id or (select auth.uid()) = entrepreneur_id);
drop policy if exists "Participants can respond retention offers" on public.retention_offers;
create policy "Participants can respond retention offers" on public.retention_offers for update to authenticated using ((select auth.uid()) = owner_id or (select auth.uid()) = entrepreneur_id) with check ((select auth.uid()) = owner_id or (select auth.uid()) = entrepreneur_id);

create or replace function public.sync_space_reservation_dates()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  update public.spaces
  set reserved_from = new.start_date,
      reserved_until = new.end_date,
      status = case when new.end_date is not null and new.end_date >= current_date then 'reserved' else 'available' end
  where id = new.space_id;
  return new;
end;
$$;

drop trigger if exists sync_space_reservation_dates on public.reservations;
create trigger sync_space_reservation_dates after insert or update of start_date, end_date, status on public.reservations for each row execute procedure public.sync_space_reservation_dates();

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, role, full_name, email)
  values (new.id, coalesce(new.raw_user_meta_data->>'role', 'entrepreneur'), coalesce(new.raw_user_meta_data->>'full_name', ''), new.email)
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute procedure public.handle_new_user();

-- Almacenamiento de fotos de propiedades.
insert into storage.buckets (id, name, public)
values ('property-photos', 'property-photos', true)
on conflict (id) do update set public = true;

drop policy if exists "Owners can upload property photos" on storage.objects;
create policy "Owners can upload property photos"
on storage.objects for insert to authenticated
with check (bucket_id = 'property-photos' and (storage.foldername(name))[1] = (select auth.uid())::text);

drop policy if exists "Owners can update property photos" on storage.objects;
create policy "Owners can update property photos"
on storage.objects for update to authenticated
using (bucket_id = 'property-photos' and (storage.foldername(name))[1] = (select auth.uid())::text)
with check (bucket_id = 'property-photos' and (storage.foldername(name))[1] = (select auth.uid())::text);

drop policy if exists "Owners can delete property photos" on storage.objects;
create policy "Owners can delete property photos"
on storage.objects for delete to authenticated
using (bucket_id = 'property-photos' and (storage.foldername(name))[1] = (select auth.uid())::text);
