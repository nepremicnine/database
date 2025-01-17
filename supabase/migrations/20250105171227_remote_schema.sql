create table "public"."search_log" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "user_id" uuid,
    "property_id" uuid,
    "search_query" text,
    "location_lat" double precision,
    "location_long" double precision,
    "location_max_dist" bigint,
    "types" property_type[],
    "price_min" bigint,
    "price_max" bigint,
    "size_min" bigint,
    "size_max" bigint
);


alter table "public"."search_log" enable row level security;

create table "public"."visited_log" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "user_id" uuid,
    "property_id" uuid
);


alter table "public"."visited_log" enable row level security;

alter table "public"."properties" alter column "size" set default '0'::bigint;

CREATE UNIQUE INDEX search_log_pkey ON public.search_log USING btree (id);

CREATE UNIQUE INDEX visited_log_pkey ON public.visited_log USING btree (id);

alter table "public"."search_log" add constraint "search_log_pkey" PRIMARY KEY using index "search_log_pkey";

alter table "public"."visited_log" add constraint "visited_log_pkey" PRIMARY KEY using index "visited_log_pkey";

alter table "public"."search_log" add constraint "search_log_property_id_fkey" FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE not valid;

alter table "public"."search_log" validate constraint "search_log_property_id_fkey";

alter table "public"."search_log" add constraint "search_log_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users_data(id) ON DELETE CASCADE not valid;

alter table "public"."search_log" validate constraint "search_log_user_id_fkey";

alter table "public"."visited_log" add constraint "visited_log_property_id_fkey" FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE not valid;

alter table "public"."visited_log" validate constraint "visited_log_property_id_fkey";

alter table "public"."visited_log" add constraint "visited_log_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users_data(id) ON DELETE CASCADE not valid;

alter table "public"."visited_log" validate constraint "visited_log_user_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.update_location_point()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  NEW.location_point = ST_SetSRID(ST_MakePoint(NEW.longitude, NEW.latitude), 4326);
  RETURN NEW;
END;
$function$
;

grant delete on table "public"."search_log" to "anon";

grant insert on table "public"."search_log" to "anon";

grant references on table "public"."search_log" to "anon";

grant select on table "public"."search_log" to "anon";

grant trigger on table "public"."search_log" to "anon";

grant truncate on table "public"."search_log" to "anon";

grant update on table "public"."search_log" to "anon";

grant delete on table "public"."search_log" to "authenticated";

grant insert on table "public"."search_log" to "authenticated";

grant references on table "public"."search_log" to "authenticated";

grant select on table "public"."search_log" to "authenticated";

grant trigger on table "public"."search_log" to "authenticated";

grant truncate on table "public"."search_log" to "authenticated";

grant update on table "public"."search_log" to "authenticated";

grant delete on table "public"."search_log" to "service_role";

grant insert on table "public"."search_log" to "service_role";

grant references on table "public"."search_log" to "service_role";

grant select on table "public"."search_log" to "service_role";

grant trigger on table "public"."search_log" to "service_role";

grant truncate on table "public"."search_log" to "service_role";

grant update on table "public"."search_log" to "service_role";

grant delete on table "public"."visited_log" to "anon";

grant insert on table "public"."visited_log" to "anon";

grant references on table "public"."visited_log" to "anon";

grant select on table "public"."visited_log" to "anon";

grant trigger on table "public"."visited_log" to "anon";

grant truncate on table "public"."visited_log" to "anon";

grant update on table "public"."visited_log" to "anon";

grant delete on table "public"."visited_log" to "authenticated";

grant insert on table "public"."visited_log" to "authenticated";

grant references on table "public"."visited_log" to "authenticated";

grant select on table "public"."visited_log" to "authenticated";

grant trigger on table "public"."visited_log" to "authenticated";

grant truncate on table "public"."visited_log" to "authenticated";

grant update on table "public"."visited_log" to "authenticated";

grant delete on table "public"."visited_log" to "service_role";

grant insert on table "public"."visited_log" to "service_role";

grant references on table "public"."visited_log" to "service_role";

grant select on table "public"."visited_log" to "service_role";

grant trigger on table "public"."visited_log" to "service_role";

grant truncate on table "public"."visited_log" to "service_role";

grant update on table "public"."visited_log" to "service_role";


