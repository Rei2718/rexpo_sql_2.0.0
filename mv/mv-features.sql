-- mv_features
DROP MATERIALIZED VIEW IF EXISTS public.mv_features CASCADE;

CREATE MATERIALIZED VIEW public.mv_features AS
SELECT
    1 AS id,
    COALESCE(
        jsonb_agg(
            jsonb_build_object(
                'feature_public_id', f.feature_public_id,
                'name',              f.name,
                'caption',           f.caption,
                'note',              f.note,
                'image',             f.image,
                'event_public_id',   e.event_public_id,
                'display_order',     f.display_order
            ) ORDER BY f.display_order DESC, f.feature_id
        ),
        '[]'::jsonb
    ) AS data

FROM public.features f
LEFT JOIN public.events e ON f.event_id = e.event_id AND e.deleted_at IS NULL
WHERE f.deleted_at IS NULL;

-- indexes
CREATE UNIQUE INDEX idx_mv_features_id ON public.mv_features(id);

-- security
REVOKE ALL ON MATERIALIZED VIEW public.mv_features FROM public;