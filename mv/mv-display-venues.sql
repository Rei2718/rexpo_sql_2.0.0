-- mv_display_venues
DROP MATERIALIZED VIEW IF EXISTS public.mv_display_venues CASCADE;

CREATE MATERIALIZED VIEW public.mv_display_venues AS
SELECT
    1 AS id,
    COALESCE(
        jsonb_agg(
            jsonb_build_object(
                'venue_public_id', v.venue_public_id,
                'name',            v.name,
                'icon',            v.icon,
                'capacity',        v.capacity,
                'floor',           v.floor,
                'map_latitude',    v.map_latitude,
                'map_longitude',   v.map_longitude,
                'display_order',   v.display_order
            ) ORDER BY v.display_order DESC, v.venue_id
        ),
        '[]'::jsonb
    ) AS data

FROM public.venues v
WHERE v.is_primary = TRUE
AND v.deleted_at IS NULL;

-- indexes
CREATE UNIQUE INDEX idx_mv_display_venues_id ON public.mv_display_venues(id);

-- security
REVOKE ALL ON MATERIALIZED VIEW public.mv_display_venues FROM public;