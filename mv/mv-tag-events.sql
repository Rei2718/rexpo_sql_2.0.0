-- mv_tag_events
DROP MATERIALIZED VIEW IF EXISTS public.mv_tag_events CASCADE;

CREATE MATERIALIZED VIEW public.mv_tag_events AS
SELECT
    t.tag_public_id,
    t.name,
    t.caption,
    t.display_order AS tag_display_order,
    COALESCE(
        jsonb_agg(
            jsonb_build_object(
                'event_public_id', e.event_public_id,
                'name',            e.name,
                'caption',         e.caption,
                'icon',            e.icon,
                'display_order',   e.display_order
            ) ORDER BY e.display_order DESC, e.event_id
        ) FILTER (WHERE e.event_id IS NOT NULL),
        '[]'::jsonb
    ) AS events

FROM public.tags t
LEFT JOIN public.events_tags et ON t.tag_id = et.tag_id AND et.deleted_at IS NULL
LEFT JOIN public.events e ON et.event_id = e.event_id AND e.deleted_at IS NULL
WHERE t.deleted_at IS NULL
GROUP BY t.tag_id, t.tag_public_id, t.name, t.caption, t.display_order;

-- indexes
CREATE UNIQUE INDEX idx_mv_tag_events_public_id ON public.mv_tag_events(tag_public_id);
CREATE INDEX idx_mv_tag_events_display_order ON public.mv_tag_events(tag_display_order DESC);

-- security
REVOKE ALL ON MATERIALIZED VIEW public.mv_tag_events FROM public;