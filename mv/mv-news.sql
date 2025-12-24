-- mv_news
DROP MATERIALIZED VIEW IF EXISTS public.mv_news CASCADE;

CREATE MATERIALIZED VIEW public.mv_news AS
SELECT
    1 AS id,
    COALESCE(
        jsonb_agg(
            jsonb_build_object(
                'news_public_id', n.news_public_id,
                'name',           n.name,
                'caption',        n.caption,
                'description',    n.description,
                'header_image',   n.header_image,
                'thumbnail',      n.thumbnail,
                'website',        n.website,
                'performer',      CASE 
                    WHEN p.performer_id IS NOT NULL THEN
                        jsonb_build_object(
                            'performer_public_id', p.performer_public_id,
                            'name',                p.name,
                            'affiliation',         p.affiliation,
                            'icon',                p.icon
                        )
                    ELSE NULL
                END,
                'display_order',  n.display_order
            ) ORDER BY n.display_order DESC, n.created_at DESC
        ),
        '[]'::jsonb
    ) AS data

FROM public.news n
LEFT JOIN public.performers p ON n.performer_id = p.performer_id AND p.deleted_at IS NULL
WHERE n.deleted_at IS NULL;

-- indexes
CREATE UNIQUE INDEX idx_mv_news_id ON public.mv_news(id);

-- security
REVOKE ALL ON MATERIALIZED VIEW public.mv_news FROM public;