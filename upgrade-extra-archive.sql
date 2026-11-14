-- Reversible removal: keep earned points and allow restoring tasks.
begin;
alter table public.extra_tasks add column if not exists archived boolean not null default false;
drop policy if exists extra_tasks_archive on public.extra_tasks;
create policy extra_tasks_archive on public.extra_tasks for update to authenticated
using(exists(select 1 from public.members where id=auth.uid()))
with check(exists(select 1 from public.members where id=auth.uid()));
grant update(archived) on public.extra_tasks to authenticated;
commit;
select 'Extra task archive ready' as result;
