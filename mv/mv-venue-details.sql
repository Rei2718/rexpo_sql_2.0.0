-- mv_venue_details
DROP MATERIALIZED VIEW IF EXISTS public.mv_venue_details;

CREATE MATERIALIZED VIEW public.mv_venue_details AS
WITH cte_organizations AS (
    SELECT 
        vo.venue_id,
        jsonb_agg(
            jsonb_build_object(
                'organization_public_id', o.organization_public_id,
                'name',                   o.name,
                'icon',                   o.icon,
                'display_order',          vo.display_order
            ) ORDER BY vo.display_order DESC, o.organization_id
        ) AS data
    FROM public.venues_organizations vo
    JOIN public.organizations o ON vo.organization_id = o.organization_id
    WHERE vo.deleted_at IS NULL AND o.deleted_at IS NULL
    GROUP BY vo.venue_id
)

SELECT
    v.venue_public_id,
    v.name,
    v.icon,
    v.map_latitude,
    v.map_longitude,
    v.is_primary,

    COALESCE(o.data, '[]'::jsonb) AS organizations

FROM public.venues v
LEFT JOIN cte_organizations o ON v.venue_id = o.venue_id
WHERE v.deleted_at IS NULL;

CREATE UNIQUE INDEX idx_mv_venue_details_id ON public.mv_venue_details(venue_public_id);

-- security
REVOKE ALL ON MATERIALIZED VIEW public.mv_venue_details FROM public;