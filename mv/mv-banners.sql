-- mv_banners
DROP MATERIALIZED VIEW IF EXISTS public.mv_banners CASCADE;

CREATE MATERIALIZED VIEW public.mv_banners AS
SELECT
    1 AS id,
    COALESCE(
        jsonb_agg(
            jsonb_build_object(
                'banner_public_id', b.banner_public_id,
                'image',            b.image,
                'link',             b.link,
                'event_public_id',  e.event_public_id,
                'display_order',    b.display_order
            ) ORDER BY b.display_order DESC, b.banner_id
        ),
        '[]'::jsonb
    ) AS data

FROM public.banners b
LEFT JOIN public.events e ON b.event_id = e.event_id AND e.deleted_at IS NULL
WHERE b.deleted_at IS NULL;

-- indexes
CREATE UNIQUE INDEX idx_mv_banners_id ON public.mv_banners(id);

-- security
REVOKE ALL ON MATERIALIZED VIEW public.mv_banners FROM public;