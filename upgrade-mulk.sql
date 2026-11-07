-- Preserves all existing progress; run before publishing the Mulk client.
begin;
alter table public.steps drop constraint if exists steps_task_check;
alter table public.steps add constraint steps_task_check check(task between 0 and 22);
commit;
